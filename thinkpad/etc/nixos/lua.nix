{pkgs}:
  {
    lua-resty-string =
        pkgs.fetchFromGitHub {
            owner = "openresty";
            repo = "lua-resty-string";
            rev = "945b7d67422e8ceb6013cf84d8603c47713a8a02";
            sha256 = "0mpzavdm2ckpc0pp6z66p8xkmssnzdcliywq4g2kdax99bqlcbd7";
          };
    lua-resty-hmac =
         pkgs.fetchFromGitHub {
           owner = "jkeys089";
           repo = "lua-resty-hmac";
           rev = "989f601acbe74dee71c1a48f3e140a427f2d03ae";
           sha256 = "1l260drflddgcf0gz41m2j1nir6v9xppqyyby4w3hsgcqphhs92h";
          };
    lua-resty-jwt = pkgs.fetchFromGitHub {
      owner = "SkyLothar";
      repo = "lua-resty-jwt";
      rev = "ee1d024071f872e2b5a66eaaf9aeaf86c5bab3ed";
      sha256 = "1nw21jg7x1d8akwv2qzybaylcsd6jj9saq70kr7r4wjg7l7lvabg";
    };
  }

