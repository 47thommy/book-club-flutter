import 'package:client/infrastructure/role/dto/permission_dto.dart';
import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:flutter/material.dart';

enum PageMode { create, edit }

class RoleDetailPage extends StatefulWidget {
  static const routeName = 'role-detail';

  final RoleDto role;
  final PageMode mode;

  const RoleDetailPage(this.role, {super.key, this.mode = PageMode.edit});

  @override
  State<RoleDetailPage> createState() => _RoleDetailPageState();
}

class _RoleDetailPageState extends State<RoleDetailPage> {
  final rolePermissions = <String>{};

  @override
  void initState() {
    for (var permission in widget.role.permissions) {
      rolePermissions.add(permission.name);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.role.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'What can members with this role do?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 18,
              ),

              //
              // Permissions
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: PermissionDto.all.length,
                  itemBuilder: (context, index) {
                    final permission = PermissionDto.all[index];
                    final permitted = rolePermissions.contains(permission.name);

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          permission.name,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (permitted) {
                                rolePermissions.remove(permission.name);
                              } else {
                                rolePermissions.add(permission.name);
                              }
                            });
                          },
                          color: permitted ? Colors.green : Colors.red,
                          icon: Icon(permitted ? Icons.check : Icons.close),
                        ),
                      ],
                    );
                  }),

              //
              // Save or create button
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(widget.mode == PageMode.create
                          ? 'Create role'
                          : 'Save role')),
                ),
              )
            ],
          ),
        ));
  }
}
