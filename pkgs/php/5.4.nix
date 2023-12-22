{ prev, mkPhp }:

let
  base = mkPhp {
    version = "5.4.45";
    hash = "sha256-Tg0osVVMlc+upvorZKrIVDPxWM5yu1cbzVV0+Y9MZYI=";
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
      # gd # Likely needs gd < v2.3; Getting `undefined symbol: gdGetC` at runtime with gd v2.3.3
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
      # opcache # Available in PECL as `ZendOpcache`?
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
