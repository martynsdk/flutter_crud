import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import '../routes/app_routes.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.userFormRoute,
                  arguments: user,
                );
              },
              icon: const Icon(Icons.edit),
              tooltip: "editUser".i18n(),
              color: Colors.orangeAccent,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: "deleteUser".i18n(),
              color: Colors.redAccent,
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("deleteUser".i18n()),
                    content: Text("areYouSure".i18n()),
                    actions: <Widget>[
                      TextButton(
                        child: Text("no".i18n()),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
                        child: Text("yes".i18n()),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  if (confirmed) {
                    Provider.of<Users>(context, listen: false).remove(user);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
