<?php
/**
 * As configurações básicas do WordPress
 *
 * O script de criação wp-config.php usa esse arquivo durante a instalação.
 * Você não precisa usar o site, você pode copiar este arquivo
 * para "wp-config.php" e preencher os valores.
 *
 * Este arquivo contém as seguintes configurações:
 *
 * * Configurações do MySQL
 * * Chaves secretas
 * * Prefixo do banco de dados
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/pt-br:Editando_wp-config.php
 *
 * @package WordPress
 */

// ** Configurações do MySQL - Você pode pegar estas informações com o serviço de hospedagem ** //
/** O nome do banco de dados do WordPress */
define('DB_NAME', 'wordpress');

/** Usuário do banco de dados MySQL */
define('DB_USER', 'root');

/** Senha do banco de dados MySQL */
define('DB_PASSWORD', 'root');

/** Nome do host do MySQL */
define('DB_HOST', 'localhost');

/** Charset do banco de dados a ser usado na criação das tabelas. */
define('DB_CHARSET', 'utf8');

/** O tipo de Collate do banco de dados. Não altere isso se tiver dúvidas. */
define('DB_COLLATE', '');

/** Diretório base do wordpress */
define('FTP_BASE', 'wordpress/');

/** Endereço do servidor FTP */
define('FTP_HOST', '192.168.33.10');

/** Usuário FTP */
define('FTP_USER', 'vagrant');

/** Senha FTP */
define('FTP_PASS', 'vagrant');

/** Caminho da pasta wp-content */
define('FTP_CONTENT_DIR', 'wordpress/wp-content/');

/** Cominho da pasta plugins */
define('FTP_PLUGIN_DIR', 'wordpress/wp-content/plugins/');
/**#@+
 * Chaves únicas de autenticação e salts.
 *
 * Altere cada chave para um frase única!
 * Você pode gerá-las
 * usando o {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org
 * secret-key service}
 * Você pode alterá-las a qualquer momento para invalidar quaisquer
 * cookies existentes. Isto irá forçar todos os
 * usuários a fazerem login novamente.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         ']{M/aK;d-Y;o*@4Az`o-w(G~YBxd6 12*+|Upxb2QlQa5-(%-m@;d+wZy/`{b*AJ');
define('SECURE_AUTH_KEY',  '|}D6PM?#jy>.)Ba;$m13P9FLX27[)%E~$WEdtN<%;Q|}stJ))HLHNX3X`q1|=[ad');
define('LOGGED_IN_KEY',    'K^?E.*(3&lYZM :$J2`|(d,3/;4?Wb@!N+$s|?x4~K.Bolu>{&.@jo/4bH4CHZu$');
define('NONCE_KEY',        '<B{EtLWFA+55+QVJE-sp{Q)r+02@-9I(iExe.X|,.4^@?mV1i(L+SN|vc,>U@!d;');
define('AUTH_SALT',        'M1%*+dV~mSa$6n6Uu:,~FB&wO<(YYKn*CsnHJ40u7MB[3}D. i/dRsx|REFJDZXf');
define('SECURE_AUTH_SALT', 't&EbBjX&ifa=|bq~%pGM@D<DDGg<BcIBAef|D.9v4Y*j`<lAt.48sb#qi%( {`4S');
define('LOGGED_IN_SALT',   '(meV^<j8bK;hDMkatl-1pMYX2-.mjnrk6tBKB9)~8n^+{}dH1l/#Xr/>wCAL4ix+');
define('NONCE_SALT',       'Yp~{zS@l)=;+/pVuoMJ7$~1)DkVabB`)(+7+0F/-WToh-9V$]{]PsQ28hjW#CDdP');

/**#@-*/

/**
 * Prefixo da tabela do banco de dados do WordPress.
 *
 * Você pode ter várias instalações em um único banco de dados se você der
 * um prefixo único para cada um. Somente números, letras e sublinhados!
 */
$table_prefix = 'wp_';

/**
 * Para desenvolvedores: Modo de debug do WordPress.
 *
 * Altere isto para true para ativar a exibição de avisos
 * durante o desenvolvimento. É altamente recomendável que os
 * desenvolvedores de plugins e temas usem o WP_DEBUG
 * em seus ambientes de desenvolvimento.
 *
 * Para informações sobre outras constantes que podem ser utilizadas
 * para depuração, visite o Codex.
 *
 * @link https://codex.wordpress.org/pt-br:Depura%C3%A7%C3%A3o_no_WordPress
 */
define('WP_DEBUG', false);

/* Isto é tudo, pode parar de editar! :) */

/** Caminho absoluto para o diretório WordPress. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Configura as variáveis e arquivos do WordPress. */
require_once(ABSPATH . 'wp-settings.php');
