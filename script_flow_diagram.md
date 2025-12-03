START
  ↓
┌─────────────────────────────────┐
│ Initialize Configuration        │
│ - Set SEMESTERS array           │
│ - Define DONE keyword           │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ Prompt: Enter Year              │
│ (stores in YEAR variable)       │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ Save Current Permissions        │
│ Set umask to 0000               │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ Prompt: Enter Root Path         │
│ (stores in ROOT_PATH)           │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ Create Year Directory           │
│ mkdir $ROOT_DIR                 │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ Loop Through SEMESTERS          │
│ Create: Spring/ Summer/ Fall/   │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ Display Semester Menu           │
│ (Spring, Summer, Fall)          │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ User Selects Semester           │
│ Set TARGET_DIR path             │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ ┌─ COURSE INPUT LOOP ─────────┐ │
│ │                             │ │
│ │ Prompt: Enter Course Name   │ │
│ │                             │ │
│ │    ┌──────────────────┐     │ │
│ │    │ Input = "done"?  │─Yes─┼─┼─→ BREAK LOOP
│ │    └──────────────────┘     │ │
│ │           │ No              │ │
│ │           ↓                 │ │
│ │    ┌──────────────────┐     │ │
│ │    │ Validate Input   │     │ │
│ │    │ (not empty)      │     │ │
│ │    └──────────────────┘     │ │
│ │           │                 │ │
│ │           ↓                 │ │
│ │    ┌──────────────────┐     │ │
│ │    │ Create Course    │     │ │
│ │    │ Directory        │     │ │
│ │    └──────────────────┘     │ │
│ │           │                 │ │
│ │           ↓                 │ │
│ │    ┌──────────────────┐     │ │
│ │    │ Create:          │     │ │
│ │    │ - assignments/   │     │ │
│ │    │ - in_class/      │     │ │
│ │    └──────────────────┘     │ │
│ │           │                 │ │
│ │           └─────────────────┘ │
│ └─────────────────────────────┘ │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ Restore Original Permissions    │
│ (reset umask)                   │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ Display Success Message         │
└─────────────────────────────────┘
  ↓
END

Final directory structure created:

$ROOT_PATH/
└── {YEAR}/
    ├── Spring/
    │   ├── {Course1}/
    │   │   ├── assignments/
    │   │   └── in_class/
    │   └── {Course2}/
    │       ├── assignments/
    │       └── in_class/
    ├── Summer/
    └── Fall/