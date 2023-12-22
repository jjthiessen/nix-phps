{ prev, mkPhp }:

let
  base = mkPhp {
    version = "5.5.38";
    hash = "sha256-RzyB67LkjKRoyu4DF2ImZlGEPXInwYqCSt2bB7k5Pjg=";
  };
in
base.withExtensions (
  { all, ... }:

  with all; (
    [
      bcmath
      calendar
      curl
      ctype
      dom
      exif
      fileinfo
      filter
      ftp
      # gd # Likely needs gd < v2.3; Getting `undefined symbol: gdPngGetVersionString` at runtime with gd v2.3.3
      gettext
      gmp
      iconv
      intl
      json
      ldap
      mbstring
      mcrypt
      mysqli
      mysqlnd
      opcache
      openssl
      pcntl
      pdo
      pdo_mysql
      pdo_odbc
      pdo_pgsql
      pdo_sqlite
      pgsql
      posix
      readline
      session
      simplexml
      sockets
      soap
      sysvsem
      sqlite3
      tokenizer
      xmlreader
      xmlwriter
      zip
      zlib
    ]
    ++ prev.lib.optionals (!prev.stdenv.isDarwin) [
      imap
    ]
  )
)
