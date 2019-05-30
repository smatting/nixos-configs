-- local cjson = require "cjson"
-- local jwt = require "resty.jwt"

-- local jwt_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9" ..
--     ".eyJmb28iOiJiYXIifQ" ..
--     ".VAoRL1IU0nOguxURF2ZcKR0SGKE1gCbqwyh8u2MLAyY"
-- local jwt_obj = jwt:verify("lua-resty-jwt", jwt_token)
-- ngx.say(cjson.encode(jwt_obj))

-- local hmac = require "cjson.safe"
-- local jwt = require "resty.jwt"
-- local aes = require "resty.aes"
-- local evp = require "resty.evp"
-- local hmac = require "resty.hmac"
-- local resty_random = require "resty.random"
-- local ffi = require "ffi"
-- ngx.say('hu ha')
--
local cjson = require "cjson"
local jwt = require "resty.jwt"


-- local jwt_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9" ..
--     ".eyJmb28iOiJiYXIifQ" ..
--     ".VAoRL1IU0nOguxURF2ZcKR0SGKE1gCbqwyh8u2MLAyY"
-- local jwt_obj = jwt:verify("lua-resty-jwt", jwt_token)

local jwt_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjowLCJ0b2tlbnMiOnsid3RwIjoiZ0FBQUFBQmN0ZEtyTEhMTjFCZnk4dEFQTlpMUVNjWlpoVVVianktU0JSNFZQVEpLdlVmZFBGbnRSVklwc1JxN2JXSkZVUU8ycDdYc28yZzl6X2JhdE1BaGJaN0s1THlmVXlVNUxtdEdYLUZ6aHJQaTBxREltTDk1YndHWVZ3MjNyZEtoS3JlNkVlM2lzckdHOXB6dWZQQ0Z4TElUa0tEN2dhUmQ5VS1rd2Y1MUhzQXRoUGJhR3FHeEVMc3dSYng1OVpvdkpOa082T3RhOWlpa0thNnljcDcySjJLN2Z4LXhWbGpfS09pZXp3aEtUZGVDRFZXeURCT19SSEg1ajJVNGd1MnVlZ2JQQ3pQTCJ9LCJjdXN0b21lcl9uYW1lIjoidGhhbGlhIn0.iMC2PYHfGnRS1HpzYkgAQ82LSFwrAjksCnVfGa0MEp4"
-- local jwt_obj = jwt:verify("secret", jwt_token)
local jwt_obj = jwt:verify("incorrect", jwt_token)

-- if jwt_obj.verified then
--     ngx.say("VERIFIED")
-- else
--     ngx.say("ACCESS DENIED!!!")
-- end

-- ngx.say("hello world")
ngx.say(ngx.var.http_Authorization);

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

 -- local hmac = require "resty.hmac"

 --    local hmac_sha1 = hmac:new("secret_key", hmac.ALGOS.SHA1)
 --    if not hmac_sha1 then
 --        ngx.say("failed to create the hmac_sha1 object")
 --        return
 --    end

 --    local ok = hmac_sha1:update("he")
 --    if not ok then
 --        ngx.say("failed to add data")
 --        return
 --    end

 --    ok = hmac_sha1:update("llo")
 --    if not ok then
 --        ngx.say("failed to add data")
 --        return
 --    end

 --    local mac = hmac_sha1:final()  -- binary mac

 --    local str = require "resty.string"
 --    ngx.say("hmac_sha1: ", str.to_hex(mac))
 --        -- output: "hmac_sha1: aee4b890b574ea8fa4f6a66aed96c3e590e5925a"

 --    -- dont forget to reset after final!
 --    if not hmac_sha1:reset() then
 --        ngx.say("failed to reset hmac_sha1")
 --        return
 --    end

 --    -- short version
 --    ngx.say("hmac_sha1: ", hmac_sha1:final("world", true))
 --        -- output: "hmac_sha1: 4e9538f1efbe565c522acfb72fce6092ea6b15e0"

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

  -- local resty_sha1 = require "resty.sha1"

  --   local sha1 = resty_sha1:new()
  --   if not sha1 then
  --       ngx.say("failed to create the sha1 object")
  --       return
  --   end

  --   local ok = sha1:update("hello, ")
  --   if not ok then
  --       ngx.say("failed to add data")
  --       return
  --   end

  --   ok = sha1:update("world")
  --   if not ok then
  --       ngx.say("failed to add data")
  --       return
  --   end

  --   local digest = sha1:final()  -- binary digest

  --   local str = require "resty.string"
  --   ngx.say("sha1: ", str.to_hex(digest))
  --       -- output: "sha1: b7e23ec29af22b0b4e41da31e868d57226121c84"

  --   local resty_md5 = require "resty.md5"
  --   local md5 = resty_md5:new()
  --   if not md5 then
  --       ngx.say("failed to create md5 object")
  --       return
  --   end

  --   local ok = md5:update("hel")
  --   if not ok then
  --       ngx.say("failed to add data")
  --       return
  --   end

  --   ok = md5:update("lo")
  --   if not ok then
  --       ngx.say("failed to add data")
  --       return
  --   end

  --   local digest = md5:final()

  --   local str = require "resty.string"
  --   ngx.say("md5: ", str.to_hex(digest))
  --       -- yield "md5: 5d41402abc4b2a76b9719d911017c592"

  --   local resty_sha224 = require "resty.sha224"
  --   local str = require "resty.string"
  --   local sha224 = resty_sha224:new()
  --   ngx.say(sha224:update("hello"))
  --   local digest = sha224:final()
  --   ngx.say("sha224: ", str.to_hex(digest))

  --   local resty_sha256 = require "resty.sha256"
  --   local str = require "resty.string"
  --   local sha256 = resty_sha256:new()
  --   ngx.say(sha256:update("hello"))
  --   local digest = sha256:final()
  --   ngx.say("sha256: ", str.to_hex(digest))

  --   local resty_sha512 = require "resty.sha512"
  --   local str = require "resty.string"
  --   local sha512 = resty_sha512:new()
  --   ngx.say(sha512:update("hello"))
  --   local digest = sha512:final()
  --   ngx.say("sha512: ", str.to_hex(digest))

  --   local resty_sha384 = require "resty.sha384"
  --   local str = require "resty.string"
  --   local sha384 = resty_sha384:new()
  --   ngx.say(sha384:update("hel"))
  --   ngx.say(sha384:update("lo"))
  --   local digest = sha384:final()
  --   ngx.say("sha384: ", str.to_hex(digest))

  --   local resty_random = require "resty.random"
  --   local str = require "resty.string"
  --   local random = resty_random.bytes(16)
  --       -- generate 16 bytes of pseudo-random data
  --   ngx.say("pseudo-random: ", str.to_hex(random))

  --   local resty_random = require "resty.random"
  --   local str = require "resty.string"
  --   local strong_random = resty_random.bytes(16,true)
  --       -- attempt to generate 16 bytes of
  --       -- cryptographically strong random data
  --   while strong_random == nil do
  --       strong_random = resty_random.bytes(16,true)
  --   end
  --   ngx.say("random: ", str.to_hex(strong_random))

  --   local aes = require "resty.aes"
  --   local str = require "resty.string"
  --   local aes_128_cbc_md5 = aes:new("AKeyForAES")
  --       -- the default cipher is AES 128 CBC with 1 round of MD5
  --       -- for the key and a nil salt
  --   local encrypted = aes_128_cbc_md5:encrypt("Secret message!")
  --   ngx.say("AES 128 CBC (MD5) Encrypted HEX: ", str.to_hex(encrypted))
  --   ngx.say("AES 128 CBC (MD5) Decrypted: ", aes_128_cbc_md5:decrypt(encrypted))

  --   local aes = require "resty.aes"
  --   local str = require "resty.string"
  --   local aes_256_cbc_sha512x5 = aes:new("AKeyForAES-256-CBC",
  --       "MySalt!!", aes.cipher(256,"cbc"), aes.hash.sha512, 5)
  --       -- AES 256 CBC with 5 rounds of SHA-512 for the key
  --       -- and a salt of "MySalt!!"
  --       -- Note: salt can be either nil or exactly 8 characters long
  --   local encrypted = aes_256_cbc_sha512x5:encrypt("Really secret message!")
  --   ngx.say("AES 256 CBC (SHA-512, salted) Encrypted HEX: ", str.to_hex(encrypted))
  --   ngx.say("AES 256 CBC (SHA-512, salted) Decrypted: ",
  --       aes_256_cbc_sha512x5:decrypt(encrypted))

  --   local aes = require "resty.aes"
  --   local str = require "resty.string"
  --   local aes_128_cbc_with_iv = assert(aes:new("1234567890123456",
  --       nil, aes.cipher(128,"cbc"), {iv="1234567890123456"}))
  --       -- AES 128 CBC with IV and no SALT
  --   local encrypted = aes_128_cbc_with_iv:encrypt("Really secret message!")
  --   ngx.say("AES 128 CBC (WITH IV) Encrypted HEX: ", str.to_hex(encrypted))
  --   ngx.say("AES 128 CBC (WITH IV) Decrypted: ",
  --       aes_128_cbc_with_iv:decrypt(encrypted))

