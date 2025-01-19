<?php
// ** Réglages MySQL - Votre hébergeur doit vous fournir ces informations. ** //

define( 'DB_NAME', getenv('WORDPRESS_DB_NAME') );
define( 'DB_USER', getenv('WORDPRESS_DB_USER') );
define( 'DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD') );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

/**#@+
 * Clés uniques d'authentification et salage.
 */
define('AUTH_KEY',         'mettez une phrase unique ici');
define('SECURE_AUTH_KEY',  'mettez une phrase unique ici');
define('LOGGED_IN_KEY',    'mettez une phrase unique ici');
define('NONCE_KEY',        'mettez une phrase unique ici');
define('AUTH_SALT',        'mettez une phrase unique ici');
define('SECURE_AUTH_SALT', 'mettez une phrase unique ici');
define('LOGGED_IN_SALT',   'mettez une phrase unique ici');
define('NONCE_SALT',       'mettez une phrase unique ici');

/**#@-*/

/**
 * Préfixe de base de données pour les tables de WordPress.
 */
$table_prefix = 'wp_';

/**
 * Pour les développeurs : le mode débogage de WordPress.
 */
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
define( 'WP_DEBUG_DISPLAY', false );

/* C'est tout, ne touchez pas à ce qui suit ! Bonne publication. */

/** Chemin absolu vers le dossier de WordPress. */
if ( ! defined( 'ABSPATH' ) )
    define( 'ABSPATH', dirname( __FILE__ ) . '/' );

/** Réglage des variables de WordPress et de ses fichiers inclus. */
require_once( ABSPATH . 'wp-settings.php' );
