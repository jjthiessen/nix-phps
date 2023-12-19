{ prev, mkPhp }:

let
  base = mkPhp {
    version = "5.3.29";
    hash = "sha256-ZzyB67LkjKRoyu4DF2ImZlGEPXInwYqCSt2bB7k5Pjg=";
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
      gettext # remove?
      gmp
      # add hash?
      iconv
      intl # remove?
      json
      ldap
      mbstring
      # add mcrypt?
      mysqli
      mysqlnd
      opcache # remove?
      openssl
      pcntl
      pdo
      pdo_mysql
      pdo_odbc
      pdo_pgsql
      pdo_sqlite # remove?
      pgsql
      posix
      readline # remove?
      session
      simplexml
      sockets
      soap
      sysvsem # remove?
      sqlite3 # remove?
      tokenizer
      # add xdebug?
      xmlreader # remove?
      xmlwriter
      zip
      zlib
    ]
    ++ prev.lib.optionals (!prev.stdenv.isDarwin) [
      imap
    ]
  )
)
