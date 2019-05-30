local cjson = require "cjson"
local jwt = require "resty.jwt"

local jwt_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjowLCJ0b2tlbnMiOnsid3RwIjoiZ0FBQUFBQmN0ZEtyTEhMTjFCZnk4dEFQTlpMUVNjWlpoVVVianktU0JSNFZQVEpLdlVmZFBGbnRSVklwc1JxN2JXSkZVUU8ycDdYc28yZzl6X2JhdE1BaGJaN0s1THlmVXlVNUxtdEdYLUZ6aHJQaTBxREltTDk1YndHWVZ3MjNyZEtoS3JlNkVlM2lzckdHOXB6dWZQQ0Z4TElUa0tEN2dhUmQ5VS1rd2Y1MUhzQXRoUGJhR3FHeEVMc3dSYng1OVpvdkpOa082T3RhOWlpa0thNnljcDcySjJLN2Z4LXhWbGpfS09pZXp3aEtUZGVDRFZXeURCT19SSEg1ajJVNGd1MnVlZ2JQQ3pQTCJ9LCJjdXN0b21lcl9uYW1lIjoidGhhbGlhIn0.iMC2PYHfGnRS1HpzYkgAQ82LSFwrAjksCnVfGa0MEp4"
local jwt_obj = jwt:verify("secret", jwt_token)
-- local jwt_obj = jwt:verify("incorrect", jwt_token)

if jwt_obj.verified then
    return
else
    ngx.exit(ngx.HTTP_UNAUTHORIZED)
end


-- ngx.say(cjson.encode(jwt_obj))
