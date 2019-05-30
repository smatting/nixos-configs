self: super: {
  nginxCustom = super.nginx.override {
    modules = let m = super.nginxModules;
    in [ m.rtmp
         m.dav
         m.moreheaders
         m.lua
       ];
  };
}
