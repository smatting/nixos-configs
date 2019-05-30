local cjson = require "cjson"
local jwt = require "resty.jwt"

local auth_header = ngx.var.http_Authorization

if auth_header == nil then
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

local _, _, jwt_token = string.find(auth_header, "Bearer (.+)")

if jwt_token == nil then
    ngx.exit(ngx.HTTP_UNAUTHORIZED)
end

-- local jwt_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjowLCJ0b2tlbnMiOnsid3RwIjoiZ0FBQUFBQmN0ZEtyTEhMTjFCZnk4dEFQTlpMUVNjWlpoVVVianktU0JSNFZQVEpLdlVmZFBGbnRSVklwc1JxN2JXSkZVUU8ycDdYc28yZzl6X2JhdE1BaGJaN0s1THlmVXlVNUxtdEdYLUZ6aHJQaTBxREltTDk1YndHWVZ3MjNyZEtoS3JlNkVlM2lzckdHOXB6dWZQQ0Z4TElUa0tEN2dhUmQ5VS1rd2Y1MUhzQXRoUGJhR3FHeEVMc3dSYng1OVpvdkpOa082T3RhOWlpa0thNnljcDcySjJLN2Z4LXhWbGpfS09pZXp3aEtUZGVDRFZXeURCT19SSEg1ajJVNGd1MnVlZ2JQQ3pQTCJ9LCJjdXN0b21lcl9uYW1lIjoidGhhbGlhIn0.iMC2PYHfGnRS1HpzYkgAQ82LSFwrAjksCnVfGa0MEp4"
local jwt_obj = jwt:verify("secret", jwt_token)

if not jwt_obj.verified then
    ngx.exit(ngx.HTTP_UNAUTHORIZED)
else
    ngx.req.set_header('x-askby-userid', jwt_obj.payload.user_id);
    ngx.req.set_header('x-askby-wtp', jwt_obj.payload.tokens.wtp);
    ngx.req.set_header('x-askby-customer-name', jwt_obj.payload.customer_name);
end
