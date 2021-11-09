package("qtjsonserializer")
    set_description("The qtjsonserializer package, brutally mutilated to build with xmake")

    add_urls("https://github.com/ohmree/QtJsonSerializer.git")
    add_versions("4.0.3", ".")

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        local qt = assert(import("detect.sdks.find_qt")(), "qt not found!")
        local qtcore_includedir = path.join(qt.includedir, "QtCore")

        assert(package:has_cxxtypes(
                   "QtJsonSerializer::SerializerBase",
                   {includes = "QtJsonSerializer/serializerbase.h",
                    configs = {includedirs = {qt.includedir, qtcore_includedir},
                               links = "Qt5Core",
                               languages = "c++17",
                               cxxflags = {"-fPIC"}}}
        ))
    end)
package_end()
