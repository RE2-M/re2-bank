local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterServerEvent('re2-bank:server:withdraw')
AddEventHandler('re2-bank:server:withdraw', function(amount, data)
    local src = source
    local xPlayer = RSGCore.Functions.GetPlayer(src)
    while xPlayer == nil do Wait(0) end
    local currentBankAmount = xPlayer.Functions.GetMoney(data.bankType)
    local requestAmount = tonumber(amount)
    if currentBankAmount >= requestAmount then
        xPlayer.Functions.RemoveMoney(data.bankType, requestAmount, 'banking-quick-withdraw')
        xPlayer.Functions.AddMoney('cash', requestAmount, 'banking-quick-withdraw')
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('withdrawSuccess')..amount..Lang:t('fromBank') , 'success')

    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('withdrawError'), 'error')
    end
end)

RegisterServerEvent('re2-bank:server:deposit')
AddEventHandler('re2-bank:server:deposit', function(amount, data)
    local src = source
    local xPlayer = RSGCore.Functions.GetPlayer(src)
    while xPlayer == nil do Wait(0) end
    local currentCashAmount = xPlayer.Functions.GetMoney("cash")
    local requestAmount = tonumber(amount)
    if currentCashAmount >= requestAmount then
        xPlayer.Functions.RemoveMoney("cash", requestAmount, 'banking-quick-deposit')
        xPlayer.Functions.AddMoney(data.bankType, requestAmount, 'banking-quick-deposit')
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('depositSuccess')..amount..Lang:t('toBank') , 'success')
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('depositError'), 'error')
    end
end)
