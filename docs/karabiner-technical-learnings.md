# Karabiner Elements Technical Learnings

This document captures important technical insights, best practices, and lessons learned during the development of the Windows-to-Mac keyboard mapping configuration.

## 📋 **Rule Processing Fundamentals**

### **Rule Priority and Processing Order**
- **Karabiner processes rules TOP-TO-BOTTOM, FIRST MATCH WINS**
- Once a rule matches, Karabiner stops processing and applies that transformation
- Later rules are ignored if an earlier rule already matched the key combination

### **Rule Sections and Priority**
Rules are organized in sections with different priorities:
1. **"fn key special cases (highest priority)"** - Processed first
2. **"Navigation shortcuts"** - Processed second  
3. **"Alphabet mappings"** - Processed third
4. **"Other modifier key mappings"** - Processed last (general transformations)

### **Key Insight: Specific Before General**
- **Specific combinations** (e.g., `fn + Tab`) should be in higher priority sections
- **General modifier mappings** (e.g., `Option → Command`) should be in lower priority sections
- This prevents general rules from interfering with specific behaviors

## ⚠️ **Common Pitfalls and Solutions**

### **Problem: Overly Broad Modifier Matching**
```json
// PROBLEMATIC - Catches everything
{
  "from": {
    "key_code": "right_option",
    "modifiers": { "optional": ["any"] }
  },
  "to": [{ "key_code": "right_command" }]
}
```

**Why it's problematic:**
- `"optional": ["any"]` matches ALL key combinations with right_option
- This rule will intercept `right_option + left_arrow` before specific navigation rules
- Transforms the modifier before specific rules can process the combination

**Solution:**
- Place specific combination rules in higher priority sections
- Or remove overly broad general rules that interfere
- Or add exclusions to general rules (more complex)

### **Problem: Rule Order Conflicts**
**Scenario:** You want both:
- `Right Option + Left Arrow` → Word navigation
- `Right Option` (alone) → `Right Command`

**What happens:**
1. User presses `Right Option + Left Arrow`
2. General rule matches first: `Right Option` → `Right Command`
3. System receives `Right Command + Left Arrow` (line start)
4. Specific rule never gets a chance to process

**Solution:**
- Move specific rules to higher priority sections
- Process `Right Option + Left Arrow` before `Right Option` alone

### **Problem: Malformed JSON Structure**
```json
// MALFORMED - Duplicate conditions
{
  "conditions": [...],
  "from": {...},
  "to": [...],
  "conditions": [...],  // ← Duplicate key!
  "type": "basic"
}
```

**Issues:**
- Invalid JSON structure
- Unpredictable behavior
- May cause rules to not work as expected

**Solution:**
- Validate JSON structure
- Use proper linting
- Ensure each key appears only once per object

## 🛠️ **Best Practices**

### **1. Rule Organization Strategy**
```
High Priority Section:
├── Specific fn key combinations (fn + Tab, fn + Backspace, etc.)
├── Specific modifier combinations (Right Option + arrows)
├── Context-specific rules (terminal vs regular apps)

Medium Priority Section:
├── Alphabet mappings (fn + A, fn + B, etc.)
├── Number mappings (fn + 1, fn + 2, etc.)  
├── Symbol mappings (fn + -, fn + =, etc.)

Low Priority Section:
├── General modifier swaps (Option ↔ Command)
├── Catch-all transformations
```

### **2. Rule Design Patterns**

**Pattern: Specific Key Combinations**
```json
{
  "description": "Right Option + Left Arrow → Option + Left Arrow (word skip left)",
  "from": {
    "key_code": "left_arrow",
    "modifiers": { "mandatory": ["right_option"] }
  },
  "to": [
    {
      "key_code": "left_arrow", 
      "modifiers": ["option"]
    }
  ]
}
```

**Pattern: Context-Aware Rules**
```json
{
  "conditions": [
    {
      "bundle_identifiers": ["com.apple.Terminal"],
      "type": "frontmost_application_if"
    }
  ],
  "description": "fn + C in terminals → Control + C",
  "from": {
    "key_code": "c",
    "modifiers": { "mandatory": ["fn"] }
  },
  "to": [
    {
      "key_code": "c",
      "modifiers": ["control"]
    }
  ]
}
```

### **3. Testing and Validation**

**Test Priority:**
1. **Critical combinations first:** Tab switching, word navigation, copy/paste
2. **Context switching:** Test in different apps (Terminal vs Browser vs Code Editor)
3. **Shift variants:** Ensure `fn + Shift + key` works when `fn + key` works
4. **No interference:** Verify new rules don't break existing functionality

**Validation Checklist:**
- [ ] JSON syntax is valid
- [ ] Rule descriptions are clear and descriptive  
- [ ] High-priority rules are in correct sections
- [ ] No conflicting rules (test key combinations)
- [ ] Context-specific rules have proper bundle identifiers

## 🎯 **Real-World Examples**

### **Example 1: Right Option Navigation Fix**

**Problem:** `Right Option + Left Arrow` went to line start instead of word navigation

**Root Cause:** General rule `Right Option → Right Command` processed first
```json
// This interfering rule caught everything first
{
  "from": { "key_code": "right_option", "modifiers": { "optional": ["any"] } },
  "to": [{ "key_code": "right_command" }]
}
```

**Solution:** 
1. Moved specific rules to highest priority section
2. Removed the overly broad general rule
3. Now `Right Option + arrows` work for word navigation

**Lesson:** Broad `"optional": ["any"]` rules are dangerous and should be avoided or carefully managed.

### **Example 2: Tab Switching Complexity**

**Problem:** Windows-style continuous tab navigation is fundamentally incompatible with macOS

**Attempts:** 11 different approaches tried, including:
- Mode-based switching with timers
- Control key simulation
- State variables and delayed actions

**Final Solution:** Simple direct mapping `fn + Tab → Control + Tab`

**Lesson:** Sometimes the simplest solution is best. Complex state management can introduce more problems than it solves.

## 🔧 **Debugging Techniques**

### **1. Rule Priority Testing**
- Add temporary test rules at different priority levels
- Use distinctive actions (like notifications) to see which rule triggers
- Gradually move rules between sections to find optimal placement

### **2. Key Combination Isolation**
- Disable broad rules temporarily
- Test specific combinations in isolation
- Re-enable general rules one by one to identify conflicts

### **3. JSON Validation**
- Use JSON linters to catch syntax errors
- Validate structure before deployment
- Keep backups before major changes

## 📚 **Reference Resources**

### **Karabiner Elements Documentation**
- [Official Complex Modifications Guide](https://karabiner-elements.pqrs.org/docs/json/)
- [Predefined Complex Modifications](https://karabiner-elements.pqrs.org/docs/json/complex-modifications-manipulator-definition/)

### **Project-Specific Documentation**
- `docs/karabiner-elements-plan.md` - Development plan and specifications
- `docs/tab-switching-progress-report.md` - Detailed history of tab switching attempts
- `README.md` - User-facing installation and usage guide

## 💡 **Future Development Guidelines**

### **Before Adding New Rules:**
1. **Identify the priority level** - Where should this rule be processed?
2. **Check for conflicts** - Will this interfere with existing rules?
3. **Plan for context** - Does this need app-specific behavior?
4. **Test thoroughly** - Verify in multiple applications and scenarios

### **When Debugging Issues:**
1. **Check rule order** - Is a general rule interfering?
2. **Validate JSON** - Are there syntax errors?
3. **Test in isolation** - Disable other rules to isolate the problem
4. **Document findings** - Add learnings to this document

---

*This document should be updated whenever new technical insights are discovered during development.* 