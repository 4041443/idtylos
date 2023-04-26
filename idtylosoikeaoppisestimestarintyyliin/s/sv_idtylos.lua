ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local admins = {
-------------Ylläpito-------------

    'steam:1100001364ddc68', --Orggis
    'steam:110000107f576c2', --Julle
    'steam:110000105ac4f6e', --Vipcola
    'steam:11000010939671b', --Felqqu
    'steam:11000010f0ea2d5', --Wade
    'steam:1100001370dce99', --JimmyN
    'steam:11000011879a46e', --Ramibob
    'steam:11000011159f15a', --Nallu
    'steam:11000010e535556', --MatiasFI
    
}

function isAdmin(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

RegisterCommand('idt', function(source, args)
    local source = source
    if source ~= 0 then
        if isAdmin(source) then
            TriggerClientEvent('idt', source)
        else
            TriggerClientEvent('esx:showNotification', source, 'Mene töihin!')
        end
    end
end)