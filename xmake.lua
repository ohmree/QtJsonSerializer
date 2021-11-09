add_rules("mode.debug", "mode.release")

package("qtjsonserializer")
    set_description("The qtjsonserializer package, brutally mutilated to build with xmake")

    add_urls("https://github.com/ohmree/QtJsonSerializer.git")
    -- HACK: maybe??
    add_versions("4.0.3", ".")

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_cxxtypes("QtJsonSerializer::SerializerBase", {includes = "QtJsonSerializer/serializerbase.h"}))
    end)
package_end()

target("QtJsonSerializer")
    add_rules("qt.shared")
    set_languages("cxx17")
    add_headerfiles("src/*.h", "src/(typeconverters/*.h)", {prefixdir = "QtJsonSerializer"})
    add_includedirs("src/")
    add_files("src/**.cpp")
    add_defines(
        "QT_DEPRECATED_WARNINGS",
        "QT_ASCII_CAST_WARNINGS",
        "NO_REGISTER_JSON_CONVERTERS",
        "QT_BUILD_JSONSERIALIZER_LIB"
    )
    add_frameworks("QtCore", "QtCorePrivate")
target_end()

--
-- If you want to known more usage about xmake, please see https://xmake.io
--
-- ## FAQ
--
-- You can enter the project directory firstly before building project.
--
--   $ cd projectdir
--
-- 1. How to build project?
--
--   $ xmake
--
-- 2. How to configure project?
--
--   $ xmake f -p [macosx|linux|iphoneos ..] -a [x86_64|i386|arm64 ..] -m [debug|release]
--
-- 3. Where is the build output directory?
--
--   The default output directory is `./build` and you can configure the output directory.
--
--   $ xmake f -o outputdir
--   $ xmake
--
-- 4. How to run and debug target after building project?
--
--   $ xmake run [targetname]
--   $ xmake run -d [targetname]
--
-- 5. How to install target to the system directory or other output directory?
--
--   $ xmake install
--   $ xmake install -o installdir
--
-- 6. Add some frequently-used compilation flags in xmake.lua
--
-- @code
--    -- add debug and release modes
--    add_rules("mode.debug", "mode.release")
--
--    -- add macro defination
--    add_defines("NDEBUG", "_GNU_SOURCE=1")
--
--    -- set warning all as error
--    set_warnings("all", "error")
--
--    -- set language: c99, c++11
--    set_languages("c99", "c++11")
--
--    -- set optimization: none, faster, fastest, smallest
--    set_optimize("fastest")
--
--    -- add include search directories
--    add_includedirs("/usr/include", "/usr/local/include")
--
--    -- add link libraries and search directories
--    add_links("tbox")
--    add_linkdirs("/usr/local/lib", "/usr/lib")
--
--    -- add system link libraries
--    add_syslinks("z", "pthread")
--
--    -- add compilation and link flags
--    add_cxflags("-stdnolib", "-fno-strict-aliasing")
--    add_ldflags("-L/usr/local/lib", "-lpthread", {force = true})
--
-- @endcode
--

