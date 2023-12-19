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
      gd # remove?
      gettext
      gmp
      # add hash?
      iconv
      intl # remove?
      json
      ldap
      mbstring
      mysqli
      mysqlnd
      opcache # remove?
      openssl
      pcntl
      pdo
      pdo_mysql
      pdo_odbc
      pdo_pgsql
      pdo_sqlite
      pgsql
      posix
      readline # remove?
      session
      simplexml
      sockets
      soap
      sysvsem # remove?
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
