#!/usr/bin/perl

# obmenu-generator - schema file

=for comment

    item:      add an item inside the menu               {item => ["command", "label", "icon"]},
    cat:       add a category inside the menu             {cat => ["name", "label", "icon"]},
    sep:       horizontal line separator                  {sep => undef}, {sep => "label"},
    pipe:      a pipe menu entry                         {pipe => ["command", "label", "icon"]},
    raw:       any valid Openbox XML string               {raw => q(xml string)},
    begin_cat: begin of a category                  {begin_cat => ["name", "icon"]},
    end_cat:   end of a category                      {end_cat => undef},
    obgenmenu: generic menu settings                {obgenmenu => ["label", "icon"]},
    exit:      default "Exit" action                     {exit => ["label", "icon"]},

=cut

# NOTE:
#    * Keys and values are case sensitive. Keep all keys lowercase.
#    * ICON can be a either a direct path to an icon or a valid icon name
#    * Category names are case insensitive. (X-XFCE and x_xfce are equivalent)

require "$ENV{HOME}/.config/obmenu-generator/config.pl";

## Text editor
#my $editor = $CONFIG->{editor};
my $editor = 'gvim';

our $SCHEMA = [

    {item => ['xterm',   'Terminal (xterm)', 'terminal']},
    {item => ['firefox', 'Firefox',          'firefox']},
    {item => ['gvim',    'gViM',             'gvim']},

    {begin_cat => ['Environnement', 'gnome-settings']},

        {sep => 'Apparence'},

        {item => ['tintwizard.py',          'Apparence de la barre des tâches',                   'tint2']},
        {item => ['pcmanfm --desktop-pref', 'Arrière-plan, préférences du bureau',                'preferences-desktop-wallpaper']},
        {item => ['obconf',                 'Gestionnaire de configuration d\'Openbox',           'obconf']},
        {item => ['lxappearance',           'Police, thème des fenêtres et icônes',               'preferences-desktop-theme']},

        {sep => 'Openbox'},

        {item => ['openbox --reconfigure',               'Appliquer la nouvelle configuration',              'view-refresh']},
        {item => ['openbox --restart',                   'Redémarrer OpenBox (safe, en cas de mise à jour)', 'view-refresh']},
        {item => ["$editor ~/.config/openbox/autostart", 'Modifier les applications au démarrage',           'accessories-text-editor']},
        {item => ["$editor ~/.config/openbox/rc.xml",    'Modifier les paramètres',                          'accessories-text-editor']},
        {item => ["$editor ~/.config/openbox/menu.xml",  'Modifier le menu',                                 'accessories-text-editor']},
        {sep => undef},
        {item => ['obmenu-generator -d',                          'Rafraichir les icônes du menu auto-généré', 'view-refresh']},
        {item => ["$editor ~/.config/obmenu-generator/schema.pl", 'Modifier le menu auto-généré',              'accessories-text-editor']},

        {sep => 'Divers'},

        {item => ['xrdb ~/.Xresources', 'Recharger ~/.Xresources', 'view-refresh']},

    {end_cat => undef},

    {sep => 'Emplacements'},

    {item => ['pcmanfm /',      '/',           'folder']},
    {item => ['pcmanfm /etc',   '/etc',        'folder']},
    {item => ['pcmanfm /media', '/media',      'folder']},
    {item => ['pcmanfm',        '/home/chris', 'user-home']},

    {sep => 'Applications'},

    {cat => ['utility',     'Accessoires',          'applications-utilities']},
    {cat => ['consoleonly', 'Applications console', 'applications-utilities']},
    {cat => ['other',       'Autres',               'applications-other']},
    {cat => ['office',      'Bureautique',          'applications-office']},
    {cat => ['development', 'Développement',        'applications-development']},
    {cat => ['education',   'Éducation',            'applications-science']},
    {cat => ['graphics',    'Graphismes',           'applications-graphics']},
    {cat => ['game',        'Jeux',                 'applications-games']},
    {cat => ['audiovideo',  'Multimédia',           'applications-multimedia']},
    {cat => ['network',     'Réseau',               'applications-internet']},
    #{sep => undef},
    #{cat => ['qt',          'QT Applications',      'qtlogo']},
    #{cat => ['gtk',         'GTK Applications',     'gnome-applications']},
    #{cat => ['x_xfce',      'XFCE Applications',    'applications-other']},
    #{cat => ['gnome',       'GNOME Applications',   'gnome-applications']},
    {sep => undef},
    {cat => ['settings',    'Configuration',        'applications-accessories']},
    {cat => ['system',      'Système',              'applications-system']},

    {sep => 'Session'},

    {item => ['lxdm -c USER_SWITCH', 'Changer d\'utilisateur/Verrouiller', 'system-lock-screen']},
    {item => ['openbox --exit',      'Fermer la session',                  'system-log-out']},
    {sep => undef},
    {item => ['systemctl reboot',    'Redémarrer l\'ordinateur',           'view-refresh']},
    {item => ['systemctl poweroff',  'Éteindre l\'ordinateur',             'system-shutdown']},

    #          COMMAND                 LABEL                ICON
    #{item => ['xdg-open .',        'File Manager',      'file-manager']},
    #{item => ['xterm',             'Terminal',          'terminal']},
    #{item => ['xdg-open http://',    'Web Browser',       'web-browser']},
    #{item => ['gmrun',             'Run command',       'system-run']},
    #{item => ['pidgin',            'Instant messaging', 'system-users']},

    #            COMMAND     LABEL        ICON
    #{pipe => ['obbrowser', 'Disk', 'drive-harddisk']},
]
