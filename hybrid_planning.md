Here’s a **semester‑wide hybrid example** for Summer 2026 with two classes fully built out. This shows how the **global Synced vs Local roots** work, while shortcuts inside each class folder keep everything contextual:

---

### 📂 Synced Root (Cloud‑backed)
```
OneDrive Home
│
├── Synced
│   ├── 2026
│   │   ├── Summer
│   │   │   ├── COP 1000 - 1
│   │   │   │   ├── Labs
│   │   │   │   ├── Misc
│   │   │   │   └── LocalFiles → shortcut to Local/2026/Summer/COP 1000 - 1/LargeFiles
│   │   │   ├── CGS 1000 - 3
│   │   │   │   ├── Labs
│   │   │   │   ├── Misc
│   │   │   │   └── LocalFiles → shortcut to Local/2026/Summer/CGS 1000 - 3/LargeFiles
```

---

### 📂 Local Root (Never synced)
```
OneDrive Home
│
└── Local
    ├── 2026
    │   ├── Summer
    │   │   ├── COP 1000 - 1
    │   │   │   ├── LargeFiles
    │   │   ├── CGS 1000 - 3
    │   │   │   ├── LargeFiles
```

---

### 🔑 How This Works
- **Synced root**: Holds all small, critical files (labs, assignments, mailing lists, etc.) that you want backed up and accessible anywhere.
- **Local root**: Holds large files (VM images, datasets, lecture recordings, etc.) that should never upload.
- **Shortcuts inside Synced**: Each class folder has a `LocalFiles` link pointing to its corresponding large‑file directory. This keeps context together without duplicating storage.

---

### ✅ Advantages
- **Global clarity**: You know exactly which root syncs and which doesn’t.
- **Contextual navigation**: When you open a class folder in Synced, you see both synced content and a link to its local counterpart.
- **Portability**: Copying a class folder to your external drive brings along the shortcut, so you don’t lose track of where the large files live.
- **No duplication**: Large files exist only once in Local, but are accessible from Synced.

---

Would you like me to also sketch out a **Fall 2026 example** with three classes, so you can see how this scales when the semester gets busier?