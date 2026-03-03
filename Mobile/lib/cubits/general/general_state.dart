part of 'general_cubit.dart';

enum SocialLink {
  twitter(SimpleIcons.x, ''),
  facebook(SimpleIcons.facebook, ''),
  instagram(SimpleIcons.instagram, ''),
  discord(SimpleIcons.youtube, '');

  const SocialLink(this.icon, this.url);

  final IconData icon;
  final String url;
}

class GeneralState extends GlobalVars with EquatableMixin {
  final bool isLoading;

  const GeneralState({this.isLoading = false});

  @override
  List<Object?> get props => [isLoading];

  GeneralState copyWith({bool? isLoading}) {
    return GeneralState(isLoading: isLoading ?? this.isLoading);
  }
}
