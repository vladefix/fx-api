# MQL Component Framework

This library defines a lightweight, object‑oriented standard for building modular applications in MQL.  
It is inspired by concepts similar to java's **OSGi**, with the goal of providing a consistent structure for components, services, and executable logic, while managing lifecycle and dependency handling.

---

## 📦 Core Concepts

### `Component`
- Base class for all entities in the framework.  
- Every object in the system is considered a **Component**.  
- Provides a common foundation for extension and integration.

---

### `Service` (extends `Component`)
- Represents a **component that exposes logic** to other components.  
- Each service has:
  - A **process ID** (internal to the framework).  
  - A **unique name**.  
  - A **lifecycle** with standardized phases:
    - **Initialization** (automatic setup).  
    - **Refresh** (reload or update settings).  
    - **Destroy** (graceful shutdown).  
- Encourages modular, reusable, and discoverable functionality.

---

### `ExecutableService` (extends `Service`)
- Specialized type of service implementing the **Command Pattern**.  
- Defines a single standardized method:
  ```mql
  call();
