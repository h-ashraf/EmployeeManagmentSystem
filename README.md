# Employee Management System with Role-Based Access

## Overview
The Employee Management System is designed to manage employees, departments, and roles efficiently. It includes role-based access control (RBAC) to ensure appropriate permissions are enforced across the database. This system also features audit logging for tracking critical actions.

## Features
1. **Employee Management:**
   - Add new employees with department and role assignments.
   - Promote employees to new roles.
2. **Role-Based Access Control:**
   - Assign specific permissions to roles (e.g., Admin, Manager, Employee).
3. **Audit Logging:**
   - Track changes and actions performed on the system.
4. **Reporting:**
   - Generate reports on employee details, including roles and departments.

## Database Schema
- **Employees:** Stores employee details like name, email, department, and role.
- **Departments:** Stores department information.
- **Roles:** Stores role information.
- **AuditLogs:** Tracks all critical actions performed on the system.

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/employee-management-rbac.git
   cd employee-management-rbac
   ```
2. Import the SQL script:
   - Open your MySQL client or admin tool.
   - Execute the `setup.sql` file.

3. Test the database:
   - Add sample data using the stored procedures.
   - Run reporting queries provided in the `setup.sql`.

4. Configure users and permissions:
   - Grant appropriate permissions for roles in MySQL.

## Stored Procedures
- **AddEmployee:** Add a new employee.
- **PromoteEmployee:** Promote an employee to a new role.
- **ViewAuditLogs:** View logs of all actions performed.

## Example Usage
```sql
CALL AddEmployee('John Doe', 'john.doe@example.com', 3, 2, '2023-01-01');
CALL PromoteEmployee(1, 1, 1); -- Promotes employee with ID 1 to Admin role.
CALL ViewAuditLogs();
```

## Requirements
- MySQL Server 8.0 or higher.
- MySQL Workbench or another client for database interaction.

## Future Enhancements
- Add APIs for integration with front-end applications.
- Implement more granular permissions.
- Extend the audit logging to include failed login attempts.

## Author
[Hamad Ashraf](https://github.com/h_ashraf)
