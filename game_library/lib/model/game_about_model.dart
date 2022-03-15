class GameAboutModel {
  final String _gameName;
  final String _gameDate;
  final String _gameContent;
  final String _gameIcon;
  final String _gameImage;

  GameAboutModel(this._gameName, this._gameDate, this._gameContent,
      this._gameIcon, this._gameImage);

  get gameName => this._gameName;

  get gameDate => this._gameDate;

  get gameContent => this._gameContent;

  get gameIcon => this._gameIcon;

  get gameImage => this._gameImage;
}
