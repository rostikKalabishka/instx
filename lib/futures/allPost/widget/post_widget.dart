import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://t3.ftcdn.net/jpg/04/49/19/08/360_F_449190831_i2whvIQdDIGtuIVWT6QfenWwmRApVJ5l.jpg'),
                      radius: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name bobasdasda sdasd',
                          style: theme.textTheme.subtitle1,
                        ),
                        Text(
                          'adsas asdasd d asdas da sadas das dfviofodgjp udfghd oif ovpdhfguiodf dsafhdsofhsdio fsduifosdg fsiod fgsuidfsdgiu',
                          style: theme.textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 45.0),
                child: AspectRatio(
                  aspectRatio:
                      1.6, // Adjust this value to control the image's aspect ratio (width / height)
                  child: Image.network(
                      'https://t3.ftcdn.net/jpg/04/49/19/08/360_F_449190831_i2whvIQdDIGtuIVWT6QfenWwmRApVJ5l.jpg'),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(FontAwesomeIcons.heart),
                        SizedBox(
                          width: 3,
                        ),
                        Text('25')
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(FontAwesomeIcons.marsStroke),
                        SizedBox(
                          width: 3,
                        ),
                        Text('2')
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(FontAwesomeIcons.comment),
                        SizedBox(
                          width: 3,
                        ),
                        Text('2')
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
