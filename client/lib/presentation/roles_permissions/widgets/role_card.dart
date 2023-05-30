import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:client/presentation/roles_permissions/role_detail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoleCard extends StatelessWidget {
  final RoleDto role;

  const RoleCard(this.role, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(role.name),
        Row(
          children: [
            IconButton(
              iconSize: 16,
              onPressed: () {
                context.pushNamed(RoleDetailPage.routeName, extra: role);
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.remove),
            ),
          ],
        ),
      ],
    );
  }
}
