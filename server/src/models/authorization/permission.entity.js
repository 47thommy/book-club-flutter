const PermissionSchema = require("typeorm").EntitySchema;

const Permission = new PermissionSchema({
  name: "Permission",

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
});

module.exports = {
  Permission,
};
