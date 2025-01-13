function reload(files)
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            hs.reload()
            return
        end
    end
end

reloadWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reload):start()
hs.alert.show("Reloading Hammerspoon config")
