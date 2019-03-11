import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mudeo/constants.dart';
import 'package:mudeo/ui/app/elevated_button.dart';
import 'package:mudeo/ui/app/form_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mudeo/ui/artist/artist_settings_vm.dart';
import 'package:mudeo/utils/localization.dart';

class ArtistSettings extends StatefulWidget {
  const ArtistSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ArtistSettingsVM viewModel;

  @override
  _ArtistSettingsState createState() => _ArtistSettingsState();
}

class _ArtistSettingsState extends State<ArtistSettings> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _handleController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _twitterController = TextEditingController();
  final _facebookController = TextEditingController();
  final _instagramController = TextEditingController();
  final _youtubeController = TextEditingController();
  final _twitchController = TextEditingController();
  final _soundCloudController = TextEditingController();
  final _websiteController = TextEditingController();
  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    if (_controllers.isNotEmpty) {
      return;
    }

    _controllers = [
      _nameController,
      _descriptionController,
      _emailController,
      _handleController,
      _twitchController,
      _facebookController,
      _instagramController,
      _youtubeController,
      _twitterController,
      _soundCloudController,
      _websiteController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final artist = widget.viewModel.state.authState.artist;
    _handleController.text = artist.handle.trim();

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final viewModel = widget.viewModel;
    final authState = viewModel.state.authState;

    final artist = authState.artist
        .rebuild((b) => b..handle = _handleController.text.trim());

    if (artist != authState.artist) {
      viewModel.onChangedArtist(artist);
    }
  }

  void _onSubmit() {
    /*
    if (!_formKey.currentState.validate()) {
      return;
    }
    widget.viewModel.onSavePressed();
    */
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    print('isChanged: ${viewModel.isChanged}');
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.profile),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: viewModel.isChanged ? () => null : null,
          )
        ],
      ),
      body: Material(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              FormCard(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    autocorrect: false,
                    controller: _handleController,
                    decoration: InputDecoration(
                      labelText: localization.handle,
                      icon: Icon(FontAwesomeIcons.at),
                    ),
                    validator: (value) =>
                        value.isEmpty ? localization.fieldIsRequired : null,
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: localization.email,
                      icon: Icon(FontAwesomeIcons.envelope),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value.isEmpty ? localization.fieldIsRequired : null,
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: localization.name,
                      icon: Icon(FontAwesomeIcons.userAlt),
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _descriptionController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: localization.description,
                      icon: Icon(FontAwesomeIcons.solidStickyNote),
                    ),
                  ),
                ],
              ),
              FormCard(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    autocorrect: false,
                    controller: _websiteController,
                    decoration: InputDecoration(
                      labelText: localization.website,
                      icon: Icon(socialIcons[kLinkTypeWebsite]),
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _youtubeController,
                    decoration: InputDecoration(
                      labelText: 'YouTube',
                      icon: Icon(socialIcons[kLinkTypeYouTube]),
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _facebookController,
                    decoration: InputDecoration(
                      labelText: 'Facebook',
                      icon: Icon(socialIcons[kLinkTypeFacebook]),
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _instagramController,
                    decoration: InputDecoration(
                      labelText: 'Instagram',
                      icon: Icon(socialIcons[kLinkTypeInstagram]),
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _twitterController,
                    decoration: InputDecoration(
                      labelText: 'Twitter',
                      icon: Icon(socialIcons[kLinkTypeTwitter]),
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _twitchController,
                    decoration: InputDecoration(
                      labelText: 'Twitch',
                      icon: Icon(socialIcons[kLinkTypeTwitch]),
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _soundCloudController,
                    decoration: InputDecoration(
                      labelText: 'SoundCloud',
                      icon: Icon(socialIcons[kLinkTypeSoundcloud]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}