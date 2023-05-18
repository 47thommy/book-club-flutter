const RoleSchema = require("typeorm").EntitySchema;
const RolePermissionSchema = require("typeorm").EntitySchema;

const Role = new RoleSchema({
  name: "Role",

  columns: {
    id: {
      primary: true,
      type: "int",
      generated: true,
    },

    name: {
      type: "varchar",
    },
  },

  relations: {
    group: {
      target: "Group",
      type: "many-to-one",
      joinColumn: true,
    },

    permissions: {
      target: "Permission",
      type: "many-to-many",
      joinTable: {
        joinColumn: { name: "roleId", referencedColumnName: "id" },
        inverseJoinColumn: { name: "permissionId" },
      },
      eager: true,
    },
  },
});

// const RolePermission = new RolePermissionSchema({
//   name: "RolePermission",

//   columns: {
//     id: {
//       primary: true,
//       type: "int",
//       generated: true,
//     },
//   },

//   relations: {
//     role: {
//       targe: "Role",
//       type: "many-to-one",
//       joinColumn:true
//     },

//     group:
//   }
// });

module.exports = {
  Role,
};
