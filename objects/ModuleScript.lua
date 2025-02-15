local ModuleScript = {}

function ModuleScript.new(instance)
    local moduleScript = {}
    local closure = getScriptClosure(instance)

    moduleScript.Instance = instance
    moduleScript.Constants = getConstants(closure)
    moduleScript.Protos = getProtos(closure)
    xpcall(function()
        moduleScript.Environment = getSenv(instance)
    end, function() moduleScript.Environment={} end)
    moduleScript.returnValue=function()
        return require(instance)
    end
    xpcall(function()
        moduleScript.Source = decompileScript(instance) or "This script has no source."
    end, function()
        moduleScript.Source = "There was an issue while decompiling."
    end)

    moduleScript.getReturnValue=function()
        return require(instance)
    end

    return moduleScript
end

return ModuleScript
