-- main.lua

local function getModule(modulePath)
    -- Obtém o caminho base do seu repositório (exemplo)
    -- ATENÇÃO: SUBSTITUA 'SEU_USUARIO' E 'SEU_REPOSITORIO' PELOS REAIS
    local BASE_URL = "https://raw.githubusercontent.com/SEU_USUARIO/SEU_REPOSITORIO/main/modules/"
    
    local url = BASE_URL .. modulePath .. ".lua"
    
    -- Tenta obter o código do módulo
    local success, content = pcall(game.HttpGet, game, url)
    
    if not success or not content or #content == 0 then
        warn("Falha ao carregar o módulo: " .. modulePath)
        return nil
    end

    -- Carrega o código como uma função
    local moduleFunction = loadstring(content)
    if not moduleFunction then
        error("Falha ao compilar o módulo: " .. modulePath)
    end

    -- Executa a função para obter a tabela (o módulo)
    local module = moduleFunction()
    return module
end

local Core = getModule("Core")

if Core and Core.start then
    Core.start() -- Inicia a execução do script principal
else
    error("O Core do script não foi carregado corretamente.")
end
