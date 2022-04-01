class GameAboutModel {
  final String _gameName;
  final String _gameDate;
  final String _gameContent;
  final String _gameIcon;
  final String _gameImage;

  GameAboutModel(this._gameName, this._gameDate, this._gameContent,
      this._gameIcon, this._gameImage);

  get gameName => _gameName;

  get gameDate => _gameDate;

  get gameContent => _gameContent;

  get gameIcon => _gameIcon;

  get gameImage => _gameImage;
}
