-- WIP
local logger = hs.logger.new("BACKUP", "info")
local allowedDevicesFile = os.getenv("HOME") .. "/.config/backup/backup.disks"

local function readAllowedDevices()
    local devices = {}
    for line in io.lines(allowedDevicesFile) do
        devices[line] = true
    end
    return devices
end

local usbWatcher = hs.usb.watcher.new(function(data)
    if data.eventType == "added" then
        local deviceKey = data.productID .. ":" .. data.vendorID

        -- Load the allowed devices
        local allowedDevices = readAllowedDevices()

        -- Check if the device is allowed
        if allowedDevices[deviceKey] then
            hs.notify.new({
                title = "Backup USB Detected",
                informativeText = "Connected: " .. data.productName
            }):send()

            logger.i("Starting backup")

            local binPath = os.getenv("HOME") .. "/.local/bin"
            local backupConfigPath = os.getenv("HOME") .. "/.config/backup/config.json"
            local backupCommand =
                "export PATH=" .. binPath .. ":/opt/homebrew/bin:$PATH && backup " .. backupConfigPath .. " " ..
                    "--no-interactive --repo=Local"

            -- Wait until device is mounted
            hs.timer.usleep(5000000)

            local output, status = hs.execute(backupCommand)

            if status then
                logger.i("Backup succeeded\n" .. output)
                hs.notify.new({
                    title = "Backup finished!"
                }):send()
            else
                logger.i("Backup failed\n" .. output)
            end
        end
    end
end)

usbWatcher:start()
