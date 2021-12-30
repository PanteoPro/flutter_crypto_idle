import 'package:crypto_idle/domain/entities/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _SettingsDataProviderFields {
  static const isMuteMusic = 'settings_music_isMuteMusic';
  static const isMuteSound = 'settings_music_isMuteSound';
  static const musicVolume = 'settings_music_musicVolume';
  static const soundVolume = 'settings_music_soundVolume';
}

class SettingsDataProvider {
  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  MusicSettings getMusicSettings() {
    final isMuteMusic = prefs.getBool(_SettingsDataProviderFields.isMuteMusic);
    final isMuteSound = prefs.getBool(_SettingsDataProviderFields.isMuteSound);
    final musicVolume = prefs.getDouble(_SettingsDataProviderFields.musicVolume);
    final soundVolume = prefs.getDouble(_SettingsDataProviderFields.soundVolume);

    return MusicSettings(
      isMuteMusic: isMuteMusic ?? false,
      isMuteSound: isMuteSound ?? false,
      musicVolume: musicVolume ?? 1,
      soundVolume: soundVolume ?? 1,
    );
  }

  Future<void> saveMusicSettings(MusicSettings settings) async {
    await prefs.setBool(_SettingsDataProviderFields.isMuteMusic, settings.isMuteMusic);
    await prefs.setBool(_SettingsDataProviderFields.isMuteSound, settings.isMuteSound);
    await prefs.setDouble(_SettingsDataProviderFields.musicVolume, settings.musicVolume);
    await prefs.setDouble(_SettingsDataProviderFields.soundVolume, settings.soundVolume);
  }
}
