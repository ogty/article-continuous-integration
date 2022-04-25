# 
#                ________   ________   _________   ___   ________   ___        _______                                    
#               |\   __  \ |\   __  \ |\___   ___\|\  \ |\   ____\ |\  \      |\  ___ \                                   
#               \ \  \|\  \\ \  \|\  \\|___ \  \_|\ \  \\ \  \___| \ \  \     \ \   __/|                                  
#                \ \   __  \\ \   _  _\    \ \  \  \ \  \\ \  \     \ \  \     \ \  \_|/__                                
#                 \ \  \ \  \\ \  \\  \|    \ \  \  \ \  \\ \  \____ \ \  \____ \ \  \_|\ \                               
#                  \ \__\ \__\\ \__\\ _\     \ \__\  \ \__\\ \_______\\ \_______\\ \_______\                              
#                   \|__|\|__| \|__|\|__|     \|__|   \|__| \|_______| \|_______| \|_______|                              
#    ________   ________   ________    _________   ___   ________    ___  ___   ________   ___  ___   ________            
#   |\   ____\ |\   __  \ |\   ___  \ |\___   ___\|\  \ |\   ___  \ |\  \|\  \ |\   __  \ |\  \|\  \ |\   ____\           
#   \ \  \___| \ \  \|\  \\ \  \\ \  \\|___ \  \_|\ \  \\ \  \\ \  \\ \  \\\  \\ \  \|\  \\ \  \\\  \\ \  \___|_          
#    \ \  \     \ \  \\\  \\ \  \\ \  \    \ \  \  \ \  \\ \  \\ \  \\ \  \\\  \\ \  \\\  \\ \  \\\  \\ \_____  \         
#     \ \  \____ \ \  \\\  \\ \  \\ \  \    \ \  \  \ \  \\ \  \\ \  \\ \  \\\  \\ \  \\\  \\ \  \\\  \\|____|\  \        
#      \ \_______\\ \_______\\ \__\\ \__\    \ \__\  \ \__\\ \__\\ \__\\ \_______\\ \_______\\ \_______\ ____\_\  \       
#       \|_______| \|_______| \|__| \|__|     \|__|   \|__| \|__| \|__| \|_______| \|_______| \|_______||\_________\      
#                                                                                                       \|_________|      
#    ___   ________    _________   _______    ________   ________   ________   _________   ___   ________   ________      
#   |\  \ |\   ___  \ |\___   ___\|\  ___ \  |\   ____\ |\   __  \ |\   __  \ |\___   ___\|\  \ |\   __  \ |\   ___  \    
#   \ \  \\ \  \\ \  \\|___ \  \_|\ \   __/| \ \  \___| \ \  \|\  \\ \  \|\  \\|___ \  \_|\ \  \\ \  \|\  \\ \  \\ \  \   
#    \ \  \\ \  \\ \  \    \ \  \  \ \  \_|/__\ \  \  ___\ \   _  _\\ \   __  \    \ \  \  \ \  \\ \  \\\  \\ \  \\ \  \  
#     \ \  \\ \  \\ \  \    \ \  \  \ \  \_|\ \\ \  \|\  \\ \  \\  \|\ \  \ \  \    \ \  \  \ \  \\ \  \\\  \\ \  \\ \  \ 
#      \ \__\\ \__\\ \__\    \ \__\  \ \_______\\ \_______\\ \__\\ _\ \ \__\ \__\    \ \__\  \ \__\\ \_______\\ \__\\ \__\
#       \|__| \|__| \|__|     \|__|   \|_______| \|_______| \|__|\|__| \|__|\|__|     \|__|   \|__| \|_______| \|__| \|__|
#                                                                                                                       
# 
# 
# DESCRIPTION:
# 
#     Article Continuous Integration (ACI), as the name implies, is a tool to help with 
#     the continuous integration of articles. Specifically, it adds several proprietary 
#     notations to the general Markdown notation. The intended audience for this tool is 
#     anyone who creates technical articles about programming.
# 
#
#
# FEATURES:
# 
#     The following is a list of features provided by ACI.
#     
#        -   Specifying files in code blocks
#        -   Code block operation
#        -   Visualization of directories by tree structure
#        -   Create a table of contents based on heading
#        -   Expand file contents in list format
#        -   Append the playground URL of the program
#
# 
#
# NOTATION:
#
#     The content enclosed in "<>" indicates a required field, and "[]" indicates an 
#     optional field. All "<file-path>" in the following notation are relative paths.
#
#
#     === Specifying files in code blocks
# 
#         Expand the source code between "<start>" and "<end>" as a code block. 
#         "<url-string>" to describe the playground URL of the expanded source code in 
#         addition to the code block. If the file does not exist, the message 
#         "No such file" is written in the code block.
#         If you want the entire contents of the program to be expanded into a code block, 
#         enter a whitespace(" ") in the "<start>" and "<end>" sections.
# 
#             ```<language>:<file-path>:<start>:<end>[:url-string]```
#
#
#     === Code block operation
#
#         In addition to the language, a sequence of the above notations can be written 
#         to join source code together. The merging is done in the order in which they 
#         are described. "<pattern>" is "<file-path>:<start>:<end>. "<pattern>" is 
#         aligned with whitespace. There is no limit to the number of joins as long as 
#         no line breaks are made
#
#             ```<language>|<pattern> <pattern>...```
#
#
#     === Visualization of directories by tree structure
#
#         Expands the tree structure of the specified directory as code blocks.
#         "<directory-path>" is also relative, as is "<file-path>".
#
#             ```tree:<directory-path>````
# 
#
#     === Create a table of contents based on heading
#
#         Expand the table of contents where the following notation is entered: 
#         "<file-name>" usually describes itself. This is to read your file content 
#         once. "<url-prefix>" writes the common content described in "[]". 
#         "[heading-start]" and "[heading-end]" are optional and allow you to specify 
#         the size range of the heading to be treated as a table of contents. Normally, 
#         the range is from 2 to 6, not including h1(#). Note that if you want to specify 
#         2 to 5, you must also specify 2.
#
#             -_|<file-name>|<url-prefix>[|heading-start[|heading-end]]
#
#
#     === Expand file contents in list format
#
#         Reads the contents of the specified file line by line and expands it in list 
#         format. The "<type>" can be "li" for bulleted or numbered "ol" as in normal HTML. 
#         "[summary-word]" to enclose the expanded contents in a list format with 
#         "<details>" tags.
#
#             -|<type>|<file-path>[|summary-word]
#
#
#     === Execution of commands in base file
#
#         Outputs the execution result of the described command as it is. The described 
#         command outputs the same operation results as if the user had entered the command 
#         manually and executed it. Therefore, an error may occur depending on the 
#         authorization. Depending on other proprietary notation methods, this method may be 
#         easier to understand in some cases.
#
#             ! <command>
#
#
#
# USAGE:
# 
#     Execute the following command and the output results will be displayed on the 
#     command line. No new files are created.
# 
#         $ awk -f aci.awk <base-file>
# 
#     To write from the base file to a new file, execute the following command.
#
#         $ awk -f aci.awk <base-file> > <target-file>
# 
#     It may be better to define it globally as its own command.
#
#

BEGIN {
    # Languages comment-out format
    # Due to the nature of awk records, comment-out prefixes across multiple lines are not 
    # used, but single-line comment-out prefixes are used.
    data["_coffee"] = "";
    data["_js"] = "";
    data["_ls"] = "";
    data["1"] = "";
    data["1in"] = "";
    data["1m"] = "";
    data["1x"] = "";
    data["2"] = "";
    data["2da"] = "";
    data["3"] = "";
    data["3in"] = "";
    data["3m"] = "";
    data["3p"] = "";
    data["3pm"] = "";
    data["3qt"] = "";
    data["3x"] = "";
    data["4"] = "";
    data["4dm"] = "";
    data["4dm"] = "//";
    data["4gl"] = "";
    data["4th"] = "";
    data["5"] = "";
    data["6"] = "";
    data["6pl"] = "";
    data["6pl"] = "#";
    data["6pm"] = "";
    data["6pm"] = "#";
    data["7"] = "";
    data["8"] = "";
    data["8xk"] = "";
    data["8xp"] = "";
    data["9"] = "";
    data["a51"] = "";
    data["a51"] = ";";
    data["abap"] = "";
    data["abbrev_defs"] = "";
    data["abnf"] = "";
    data["abnf"] = ";";
    data["ada"] = "--";
    data["ada"] = "";
    data["adb"] = "";
    data["adml"] = "";
    data["adml"] = "<!--";
    data["admx"] = "";
    data["admx"] = "<!--";
    data["ado"] = "";
    data["ado"] = "//";
    data["adoc"] = "";
    data["adp"] = "";
    data["adp"] = "#";
    data["ads"] = "--";
    data["ads"] = "";
    data["afm"] = "";
    data["agc"] = "";
    data["agc"] = "#";
    data["agda"] = "--";
    data["agda"] = "";
    data["ahk"] = "";
    data["ahk"] = ";";
    data["ahkl"] = "";
    data["ahkl"] = ";";
    data["aidl"] = "";
    data["aidl"] = "//";
    data["aj"] = "";
    data["aj"] = "//";
    data["al"] = "";
    data["al"] = "#";
    data["als"] = "";
    data["als"] = "//";
    data["ampl"] = "";
    data["ampl"] = "#";
    data["angelscript"] = "";
    data["angelscript"] = "//";
    data["anim"] = "";
    data["anim"] = "#";
    data["ant"] = "";
    data["ant"] = "<!--";
    data["apacheconf"] = "";
    data["apacheconf"] = "#";
    data["apib"] = "";
    data["apl"] = "";
    data["app"] = "";
    data["applescript"] = "";
    data["applescript"] = "#";
    data["arc"] = "";
    data["arcconfig"] = "";
    data["arpa"] = "";
    data["as"] = "";
    data["as"] = "//";
    data["asax"] = "";
    data["asax"] = "<!--";
    data["asc"] = "";
    data["asc"] = "//";
    data["asciidoc"] = "";
    data["ascx"] = "";
    data["ascx"] = "<!--";
    data["asd"] = "";
    data["asddls"] = "--";
    data["asddls"] = "";
    data["ash"] = "";
    data["ash"] = "//";
    data["ashx"] = "";
    data["ashx"] = "<!--";
    data["asl"] = "";
    data["asl"] = "//";
    data["asm"] = "";
    data["asm"] = ";";
    data["asmx"] = "";
    data["asmx"] = "<!--";
    data["asn"] = "--";
    data["asn"] = "";
    data["asn1"] = "--";
    data["asn1"] = "";
    data["asp"] = "";
    data["asp"] = "<!--";
    data["aspx"] = "";
    data["aspx"] = "<!--";
    data["asset"] = "";
    data["asset"] = "#";
    data["astro"] = "";
    data["astro"] = "<!--";
    data["asy"] = "";
    data["asy"] = "//";
    data["atomignore"] = "";
    data["au3"] = "";
    data["au3"] = ";";
    data["aug"] = "";
    data["auk"] = "";
    data["auk"] = "#";
    data["auto-changelog"] = "";
    data["aux"] = "";
    data["avdl"] = "";
    data["avdl"] = "//";
    data["avsc"] = "";
    data["aw"] = "";
    data["aw"] = "#";
    data["awk"] = "";
    data["awk"] = "#";
    data["axaml"] = "";
    data["axaml"] = "<!--";
    data["axd"] = "";
    data["axd"] = "<!--";
    data["axi"] = "";
    data["axi"] = "//";
    data["axml"] = "";
    data["axml"] = "<!--";
    data["axs"] = "";
    data["axs"] = "//";
    data["b"] = "";
    data["babelignore"] = "";
    data["babelrc"] = "";
    data["bal"] = "";
    data["bal"] = "#";
    data["bas"] = "";
    data["bas"] = "rem";
    data["bash"] = "";
    data["bash"] = "#";
    data["bash_aliases"] = "";
    data["bash_history"] = "";
    data["bash_logout"] = "";
    data["bash_profile"] = "";
    data["bashrc"] = "";
    data["bat"] = "";
    data["bat"] = "rem";
    data["bats"] = "";
    data["bats"] = "#";
    data["bb"] = "";
    data["bbx"] = "";
    data["bdf"] = "";
    data["bdy"] = "";
    data["be"] = "";
    data["be"] = "#";
    data["befunge"] = "";
    data["bf"] = "";
    data["bf"] = "//";
    data["bi"] = "";
    data["bib"] = "";
    data["bibtex"] = "";
    data["bicep"] = "";
    data["bicep"] = "//";
    data["bison"] = "";
    data["bison"] = "/*";
    data["blade"] = "";
    data["blade"] = "<!--";
    data["bmx"] = "";
    data["bmx"] = "rem";
    data["bones"] = "";
    data["boo"] = "";
    data["boo"] = "#";
    data["boot"] = "";
    data["bpl"] = "";
    data["bpl"] = "//";
    data["brd"] = "";
    data["bro"] = "";
    data["bro"] = "#";
    data["browserslistrc"] = "";
    data["brs"] = "";
    data["bsl"] = "";
    data["bsl"] = "//";
    data["bsv"] = "";
    data["bsv"] = "//";
    data["builder"] = "";
    data["builder"] = "#";
    data["builds"] = "";
    data["builds"] = "<!--";
    data["bzl"] = "";
    data["bzl"] = "#";
    data["bzrignore"] = "";
    data["c-objdump"] = "";
    data["c"] = "";
    data["c"] = "//";
    data["c#"] = "//";
    data["c++-objdump"] = "";
    data["c++"] = "";
    data["c++"] = "//";
    data["c++objdump"] = "";
    data["c8rc"] = "";
    data["cabal"] = "--";
    data["cabal"] = "";
    data["cairo"] = "";
    data["cairo"] = "#";
    data["cake"] = "";
    data["cake"] = "//";
    data["capnp"] = "";
    data["capnp"] = "#";
    data["cats"] = "";
    data["cats"] = "//";
    data["cbl"] = "";
    data["cbl"] = "*";
    data["cbx"] = "";
    data["cc"] = "";
    data["cc"] = "//";
    data["ccp"] = "";
    data["ccp"] = "*";
    data["ccproj"] = "";
    data["ccproj"] = "<!--";
    data["ccxml"] = "";
    data["ccxml"] = "<!--";
    data["cdc"] = "";
    data["cdc"] = "//";
    data["cdf"] = "";
    data["ceylon"] = "";
    data["ceylon"] = "//";
    data["cfc"] = "";
    data["cfg"] = "";
    data["cfm"] = "";
    data["cfml"] = "";
    data["cgi"] = "";
    data["cgi"] = "#";
    data["cginc"] = "";
    data["ch"] = "";
    data["chem"] = "";
    data["chpl"] = "";
    data["chpl"] = "//";
    data["chs"] = "--";
    data["chs"] = "";
    data["cil"] = "";
    data["cil"] = ";";
    data["cirru"] = "";
    data["cjs"] = "";
    data["cjsx"] = "";
    data["ck"] = "";
    data["ck"] = "//";
    data["cl"] = "";
    data["cl"] = ";";
    data["cl2"] = "";
    data["clang-format"] = "";
    data["clang-tidy"] = "";
    data["clar"] = "";
    data["clar"] = ";";
    data["classpath"] = "";
    data["click"] = "";
    data["clixml"] = "";
    data["clixml"] = "<!--";
    data["clj"] = "";
    data["cljc"] = "";
    data["cljs"] = "";
    data["cljscm"] = "";
    data["cljx"] = "";
    data["clp"] = "";
    data["clp"] = ";";
    data["cls"] = "";
    data["cls"] = "//";
    data["clw"] = "!";
    data["clw"] = "";
    data["cmake"] = "";
    data["cmake"] = "#";
    data["cmd"] = "";
    data["cmd"] = "rem";
    data["cmp"] = "";
    data["cnc"] = "";
    data["cob"] = "";
    data["cob"] = "*";
    data["cobol"] = "";
    data["cobol"] = "*";
    data["cocci"] = "";
    data["cocci"] = "//";
    data["code-snippets"] = "";
    data["coffee"] = "";
    data["coffeelintignore"] = "";
    data["com"] = "";
    data["command"] = "";
    data["command"] = "#";
    data["conll"] = "";
    data["conllu"] = "";
    data["coq"] = "";
    data["cp"] = "";
    data["cp"] = "//";
    data["cpp-objdump"] = "";
    data["cpp"] = "";
    data["cpp"] = "//";
    data["cppobjdump"] = "";
    data["cproject"] = "";
    data["cproject"] = "<!--";
    data["cps"] = "";
    data["cpy"] = "";
    data["cpy"] = "*";
    data["cql"] = "";
    data["cql"] = "#";
    data["cr"] = "";
    data["creole"] = "";
    data["cs"] = "";
    data["cs"] = "//";
    data["csc"] = "";
    data["cscfg"] = "";
    data["cscfg"] = "<!--";
    data["csd"] = "";
    data["csdef"] = "";
    data["csdef"] = "<!--";
    data["csh"] = "";
    data["csh"] = "#";
    data["cshrc"] = "";
    data["cshtml"] = "";
    data["csl"] = "";
    data["csl"] = "//";
    data["cson"] = "";
    data["cson"] = "#";
    data["csproj"] = "";
    data["csproj"] = "<!--";
    data["css"] = "";
    data["css"] = "/*";
    data["csv"] = "";
    data["csx"] = "";
    data["csx"] = "//";
    data["ct"] = "";
    data["ct"] = "<!--";
    data["ctp"] = "";
    data["ctp"] = "#";
    data["cu"] = "";
    data["cue"] = "";
    data["cue"] = "//";
    data["cuh"] = "";
    data["curlrc"] = "";
    data["curry"] = "";
    data["cvsignore"] = "";
    data["cw"] = "";
    data["cwl"] = "";
    data["cxx-objdump"] = "";
    data["cxx"] = "";
    data["cxx"] = "//";
    data["cy"] = "";
    data["d-objdump"] = "";
    data["d"] = "";
    data["dae"] = "";
    data["dae"] = "<!--";
    data["darcspatch"] = "";
    data["dart"] = "";
    data["dart"] = "//";
    data["dats"] = "";
    data["dats"] = "//";
    data["db2"] = "";
    data["db2"] = "#";
    data["dcl"] = "";
    data["ddl"] = "";
    data["decls"] = "";
    data["depproj"] = "";
    data["desktop"] = "";
    data["desktop"] = "#";
    data["devcontainer"] = "";
    data["dfm"] = "";
    data["dfy"] = "";
    data["dhall"] = "";
    data["di"] = "";
    data["diff"] = "";
    data["dir_colors"] = "";
    data["dircolors"] = "";
    data["dircolors"] = "#";
    data["dita"] = "";
    data["ditamap"] = "";
    data["ditaval"] = "";
    data["djs"] = "";
    data["dll"] = "";
    data["dlm"] = "";
    data["dm"] = "";
    data["do"] = "";
    data["do"] = "//";
    data["dockerfile"] = "";
    data["dockerfile"] = "#";
    data["dockerignore"] = "";
    data["dof"] = "";
    data["doh"] = "";
    data["doh"] = "//";
    data["dot"] = "";
    data["dot"] = "//";
    data["dotsettings"] = "";
    data["dpatch"] = "";
    data["dpr"] = "";
    data["druby"] = "";
    data["dsc"] = "";
    data["dsl"] = "";
    data["dsl"] = "//";
    data["dsp"] = "";
    data["dtx"] = "";
    data["duby"] = "";
    data["dwl"] = "";
    data["dyalog"] = "";
    data["dyl"] = "";
    data["dylan"] = "";
    data["e"] = "";
    data["eam"] = "";
    data["eb"] = "";
    data["ebnf"] = "";
    data["ebuild"] = "";
    data["ec"] = "";
    data["ec"] = "//";
    data["ecl"] = "";
    data["eclass"] = "";
    data["eclxml"] = "";
    data["ecr"] = "";
    data["ect"] = "";
    data["edc"] = "";
    data["editorconfig"] = "";
    data["edn"] = "";
    data["edn"] = ";";
    data["eex"] = "";
    data["eh"] = "";
    data["eh"] = "//";
    data["ejs"] = "";
    data["el"] = "";
    data["eleventyignore"] = "";
    data["eliom"] = "";
    data["eliomi"] = "";
    data["elm"] = "";
    data["em"] = "";
    data["emacs"] = "";
    data["emberscript"] = "";
    data["eml"] = "";
    data["env"] = "";
    data["env"] = "#";
    data["epj"] = "";
    data["eps"] = "";
    data["epsi"] = "";
    data["eq"] = "";
    data["erb"] = "";
    data["erl"] = "";
    data["es"] = "";
    data["es6"] = "";
    data["escript"] = "";
    data["eslintignore"] = "";
    data["eslintrc"] = "";
    data["ex"] = "";
    data["exrc"] = "";
    data["exs"] = "";
    data["eye"] = "";
    data["eye"] = "#";
    data["f"] = "";
    data["f03"] = "";
    data["f08"] = "";
    data["f77"] = "";
    data["f90"] = "";
    data["f95"] = "";
    data["factor-boot-rc"] = "";
    data["factor-rc"] = "";
    data["factor"] = "";
    data["fan"] = "";
    data["fancypack"] = "";
    data["fcgi"] = "--";
    data["fcgi"] = "";
    data["fea"] = "";
    data["fea"] = "#";
    data["feature"] = "";
    data["filters"] = "";
    data["fish"] = "";
    data["fish"] = "#";
    data["flake8"] = "";
    data["flaskenv"] = "";
    data["flex"] = "";
    data["flf"] = "";
    data["flux"] = "";
    data["fnc"] = "";
    data["fnl"] = "";
    data["for"] = "";
    data["forth"] = "";
    data["fp"] = "";
    data["fp"] = "//";
    data["fpp"] = "";
    data["fr"] = "";
    data["frag"] = "";
    data["frag"] = "//";
    data["frg"] = "";
    data["frg"] = "//";
    data["frm"] = "";
    data["frt"] = "";
    data["frx"] = "";
    data["fs"] = "";
    data["fs"] = "//";
    data["fsh"] = "";
    data["fsh"] = "//";
    data["fshader"] = "";
    data["fshader"] = "//";
    data["fsi"] = "";
    data["fsproj"] = "";
    data["fst"] = "";
    data["fsx"] = "";
    data["fth"] = "";
    data["ftl"] = "";
    data["fun"] = "";
    data["fut"] = "";
    data["fx"] = "";
    data["fxh"] = "";
    data["fxml"] = "";
    data["fy"] = "";
    data["g"] = "";
    data["g4"] = "";
    data["g4"] = "//";
    data["gaml"] = "";
    data["gap"] = "";
    data["gawk"] = "";
    data["gawk"] = "#";
    data["gbl"] = "";
    data["gbo"] = "";
    data["gbp"] = "";
    data["gbr"] = "";
    data["gbs"] = "";
    data["gclient"] = "";
    data["gco"] = "";
    data["gcode"] = "";
    data["gd"] = "";
    data["gdb"] = "";
    data["gdbinit"] = "";
    data["ged"] = "";
    data["gemrc"] = "";
    data["gemspec"] = "";
    data["gemspec"] = "#";
    data["geo"] = "";
    data["geo"] = "//";
    data["geojson"] = "";
    data["geom"] = "";
    data["geom"] = "//";
    data["gf"] = "";
    data["gi"] = "";
    data["gitattributes"] = "";
    data["gitconfig"] = "";
    data["gitignore"] = "";
    data["gitmodules"] = "";
    data["gko"] = "";
    data["glade"] = "";
    data["gleam"] = "";
    data["glf"] = "";
    data["glsl"] = "";
    data["glsl"] = "//";
    data["glslf"] = "";
    data["glslf"] = "//";
    data["glslv"] = "";
    data["glslv"] = "//";
    data["gltf"] = "";
    data["glyphs"] = "";
    data["glyphs"] = "//";
    data["gml"] = "";
    data["gms"] = "";
    data["gmx"] = "";
    data["gn"] = "";
    data["gni"] = "";
    data["gnu"] = "";
    data["gnuplot"] = "";
    data["gnus"] = "";
    data["go"] = "";
    data["go"] = "//";
    data["god"] = "";
    data["god"] = "#";
    data["golo"] = "";
    data["gp"] = "";
    data["gpb"] = "";
    data["gpt"] = "";
    data["gql"] = "";
    data["grace"] = "";
    data["gradle"] = "";
    data["graphql"] = "";
    data["graphqls"] = "";
    data["groovy"] = "";
    data["grt"] = "";
    data["grxml"] = "";
    data["gs"] = "";
    data["gs"] = "//";
    data["gsc"] = "";
    data["gsh"] = "";
    data["gshader"] = "";
    data["gshader"] = "//";
    data["gsp"] = "";
    data["gst"] = "";
    data["gsx"] = "";
    data["gtl"] = "";
    data["gto"] = "";
    data["gtp"] = "";
    data["gtpl"] = "";
    data["gts"] = "";
    data["gv"] = "";
    data["gvimrc"] = "";
    data["gvy"] = "";
    data["gyp"] = "";
    data["gypi"] = "";
    data["h"] = "";
    data["h"] = "//";
    data["h++"] = "";
    data["h++"] = "//";
    data["hack"] = "";
    data["haml"] = "";
    data["handlebars"] = "";
    data["har"] = "";
    data["haskell"] = "--";
    data["hats"] = "";
    data["hats"] = "//";
    data["hb"] = "";
    data["hbs"] = "";
    data["hc"] = "";
    data["hcl"] = "";
    data["hh"] = "";
    data["hhi"] = "";
    data["hic"] = "";
    data["hlean"] = "";
    data["hlsl"] = "";
    data["hlsli"] = "";
    data["hoon"] = "";
    data["hpp"] = "";
    data["hpp"] = "//";
    data["hqf"] = "";
    data["hqf"] = "//";
    data["hql"] = "";
    data["hrl"] = "";
    data["hs-boot"] = "";
    data["hs"] = "";
    data["hsc"] = "";
    data["hta"] = "";
    data["htaccess"] = "";
    data["htm"] = "";
    data["html"] = "";
    data["html"] = "<!--";
    data["htmlhintrc"] = "";
    data["http"] = "";
    data["hx"] = "";
    data["hxml"] = "";
    data["hxsl"] = "";
    data["hxx"] = "";
    data["hxx"] = "//";
    data["hy"] = "";
    data["hzp"] = "";
    data["i"] = "";
    data["i"] = ";";
    data["i3"] = "";
    data["i7x"] = "";
    data["ice"] = "";
    data["iced"] = "";
    data["icl"] = "";
    data["idc"] = "";
    data["idc"] = "//";
    data["idr"] = "";
    data["ig"] = "";
    data["ihlp"] = "";
    data["ihlp"] = "//";
    data["ijm"] = "";
    data["ijs"] = "";
    data["ik"] = "";
    data["ily"] = "";
    data["imgbotconfig"] = "";
    data["iml"] = "";
    data["inc"] = "";
    data["inc"] = "#";
    data["ini"] = "";
    data["inl"] = "";
    data["inl"] = "//";
    data["ino"] = "";
    data["ino"] = "//";
    data["inputrc"] = "";
    data["inputrc"] = "#";
    data["ins"] = "";
    data["intr"] = "";
    data["io"] = "";
    data["iol"] = "";
    data["ipf"] = "";
    data["ipp"] = "";
    data["ipp"] = "//";
    data["ipynb"] = "";
    data["irbrc"] = "";
    data["irclog"] = "";
    data["isl"] = "";
    data["iss"] = "";
    data["iuml"] = "";
    data["ivy"] = "";
    data["ixx"] = "";
    data["ixx"] = "//";
    data["j"] = "";
    data["j2"] = "";
    data["jade"] = "";
    data["jake"] = "";
    data["janet"] = "";
    data["jav"] = "";
    data["java"] = "";
    data["java"] = "//";
    data["javascript"] = "";
    data["javascript"] = "//";
    data["jbuilder"] = "";
    data["jbuilder"] = "#";
    data["jelly"] = "";
    data["jflex"] = "";
    data["jinja"] = "";
    data["jinja2"] = "";
    data["jison"] = "";
    data["jisonlex"] = "";
    data["jl"] = "";
    data["jl"] = "#";
    data["jq"] = "";
    data["jq"] = "#";
    data["js"] = "";
    data["js"] = "//";
    data["jsb"] = "";
    data["jscad"] = "";
    data["jscsrc"] = "";
    data["jsfl"] = "";
    data["jshintrc"] = "";
    data["jslib"] = "";
    data["jslintrc"] = "";
    data["jsm"] = "";
    data["JSON-tmLanguage"] = "";
    data["json"] = "";
    data["json5"] = "";
    data["jsonc"] = "";
    data["jsonl"] = "";
    data["jsonld"] = "";
    data["jsonnet"] = "";
    data["jsp"] = "";
    data["jspre"] = "";
    data["jsproj"] = "";
    data["jss"] = "";
    data["jst"] = "";
    data["jsx"] = "";
    data["julia"] = "#";
    data["kak"] = "";
    data["kicad_mod"] = "";
    data["kicad_pcb"] = "";
    data["kicad_wks"] = "";
    data["kid"] = "";
    data["kit"] = "";
    data["kml"] = "";
    data["kojo"] = "";
    data["kojo"] = "//";
    data["krl"] = "";
    data["ksh"] = "";
    data["ksh"] = "#";
    data["kshrc"] = "";
    data["ksy"] = "";
    data["kt"] = "";
    data["ktm"] = "";
    data["kts"] = "";
    data["kv"] = "";
    data["kv"] = "#";
    data["l"] = "";
    data["lagda"] = "";
    data["lark"] = "";
    data["las"] = "";
    data["lasso"] = "";
    data["lasso8"] = "";
    data["lasso9"] = "";
    data["latte"] = "";
    data["launch"] = "";
    data["lbx"] = "";
    data["ld"] = "";
    data["lds"] = "";
    data["lean"] = "";
    data["lektorproject"] = "";
    data["less"] = "";
    data["lex"] = "";
    data["lfe"] = "";
    data["lgt"] = "";
    data["lhs"] = "";
    data["libsonnet"] = "";
    data["lid"] = "";
    data["lidr"] = "";
    data["ligo"] = "";
    data["linq"] = "";
    data["linq"] = "//";
    data["liquid"] = "";
    data["lisp"] = "";
    data["lisp"] = ";";
    data["litcoffee"] = "";
    data["ll"] = "";
    data["lmi"] = "";
    data["login"] = "";
    data["logtalk"] = "";
    data["lol"] = "";
    data["lookml"] = "";
    data["lpr"] = "";
    data["ls"] = "";
    data["lsl"] = "";
    data["lslp"] = "";
    data["lsp"] = "";
    data["lsp"] = ";";
    data["ltx"] = "";
    data["lua"] = "--";
    data["lua"] = "";
    data["luacheckrc"] = "";
    data["lvlib"] = "";
    data["lvproj"] = "";
    data["ly"] = "";
    data["m"] = "";
    data["m2"] = "";
    data["m3"] = "";
    data["m4"] = "";
    data["ma"] = "";
    data["mak"] = "";
    data["make"] = "";
    data["makefile"] = "";
    data["makefile"] = "#";
    data["mako"] = "";
    data["man"] = "";
    data["mao"] = "";
    data["markdown"] = "";
    data["markdownlintignore"] = "";
    data["marko"] = "";
    data["mask"] = "";
    data["mask"] = "//";
    data["mat"] = "";
    data["mat"] = "#";
    data["mata"] = "";
    data["mata"] = "//";
    data["matah"] = "";
    data["matah"] = "//";
    data["mathematica"] = "";
    data["matlab"] = "";
    data["mawk"] = "";
    data["mawk"] = "#";
    data["maxhelp"] = "";
    data["maxpat"] = "";
    data["maxproj"] = "";
    data["mbox"] = "";
    data["mc"] = "";
    data["mc"] = "#";
    data["mcfunction"] = "";
    data["mcfunction"] = "#";
    data["mcmeta"] = "";
    data["mcr"] = "";
    data["md"] = "";
    data["mdoc"] = "";
    data["mdown"] = "";
    data["mdpolicy"] = "";
    data["mdwn"] = "";
    data["mdx"] = "";
    data["me"] = "";
    data["mediawiki"] = "";
    data["mediawiki"] = "<!--";
    data["meta"] = "";
    data["meta"] = "#";
    data["metal"] = "";
    data["mg"] = "";
    data["minid"] = "";
    data["mint"] = "";
    data["mir"] = "";
    data["mir"] = "#";
    data["mirah"] = "";
    data["mjml"] = "";
    data["mjs"] = "";
    data["mk"] = "";
    data["mk"] = "#";
    data["mkd"] = "";
    data["mkdn"] = "";
    data["mkdown"] = "";
    data["mkfile"] = "";
    data["mkii"] = "";
    data["mkiv"] = "";
    data["mkvi"] = "";
    data["ml"] = "";
    data["ml4"] = "";
    data["mli"] = "";
    data["mligo"] = "";
    data["mligo"] = "//";
    data["mlir"] = "";
    data["mll"] = "";
    data["mly"] = "";
    data["mm"] = "";
    data["mm"] = "//";
    data["mmk"] = "";
    data["mms"] = "";
    data["mo"] = "";
    data["mod"] = "";
    data["model"] = "";
    data["monkey"] = "";
    data["monkey2"] = "";
    data["moo"] = "";
    data["moon"] = "";
    data["mq4"] = "";
    data["mq5"] = "";
    data["mqh"] = "";
    data["mrc"] = "";
    data["mrc"] = "/*";
    data["ms"] = "--";
    data["ms"] = "";
    data["mspec"] = "";
    data["mspec"] = "#";
    data["mss"] = "";
    data["mss"] = "//";
    data["mt"] = "";
    data["mtl"] = "";
    data["mtl"] = "#";
    data["mtml"] = "";
    data["mu"] = "";
    data["mu"] = "//";
    data["mud"] = "";
    data["mud"] = ";";
    data["muf"] = "";
    data["mumps"] = "";
    data["muse"] = "";
    data["mustache"] = "";
    data["mxml"] = "";
    data["mxt"] = "";
    data["mysql"] = "";
    data["mysql"] = "#";
    data["myt"] = "";
    data["n"] = "";
    data["n"] = "//";
    data["nanorc"] = "";
    data["nanorc"] = "#";
    data["nasl"] = "";
    data["nasm"] = "";
    data["nasm"] = ";";
    data["natvis"] = "";
    data["nawk"] = "";
    data["nawk"] = "#";
    data["nb"] = "";
    data["nbp"] = "";
    data["nc"] = "";
    data["nc"] = "//";
    data["ncl"] = "";
    data["ndproj"] = "";
    data["ne"] = "";
    data["ne"] = "#";
    data["nearley"] = "";
    data["nearley"] = "#";
    data["neon"] = "";
    data["neon"] = "#";
    data["nf"] = "";
    data["nf"] = "//";
    data["nginx"] = "";
    data["nginx"] = "#";
    data["nginxconf"] = "";
    data["nginxconf"] = "#";
    data["ni"] = "";
    data["nim"] = "";
    data["nim"] = "#";
    data["nimble"] = "";
    data["nimrod"] = "";
    data["nims"] = "";
    data["ninja"] = "";
    data["ninja"] = "#";
    data["nit"] = "";
    data["nit"] = "#";
    data["nix"] = "";
    data["nix"] = "#";
    data["njk"] = "";
    data["njk"] = "<!--";
    data["njs"] = "";
    data["nl"] = "";
    data["nlogo"] = "";
    data["nlogo"] = ";";
    data["no"] = "";
    data["nodemonignore"] = "";
    data["nomad"] = "";
    data["npmignore"] = "";
    data["npmrc"] = "";
    data["npmrc"] = "#";
    data["nproj"] = "";
    data["nqp"] = "";
    data["nqp"] = "#";
    data["nr"] = "";
    data["nse"] = "";
    data["nsh"] = "";
    data["nsh"] = "#";
    data["nsi"] = "";
    data["nsi"] = "#";
    data["nss"] = "";
    data["nss"] = "//";
    data["nu"] = "";
    data["nu"] = "#";
    data["numpy"] = "";
    data["numpyw"] = "";
    data["numsc"] = "";
    data["nuspec"] = "";
    data["nut"] = "";
    data["nut"] = "#";
    data["nvimrc"] = "";
    data["ny"] = "";
    data["nycrc"] = "";
    data["obj"] = "";
    data["obj"] = "#";
    data["objdump"] = "";
    data["objdump"] = "//";
    data["objectivec"] = "//";
    data["odd"] = "";
    data["odin"] = "";
    data["odin"] = "//";
    data["odin"] = "//";
    data["ol"] = "";
    data["omgrofl"] = "";
    data["ooc"] = "";
    data["ooc"] = "//";
    data["opa"] = "";
    data["opa"] = "//";
    data["opal"] = "--";
    data["opal"] = "";
    data["opencl"] = "";
    data["opencl"] = "//";
    data["orc"] = "";
    data["org"] = "";
    data["os"] = "";
    data["os"] = "//";
    data["osm"] = "";
    data["OutJob"] = "";
    data["OutJob"] = "#";
    data["owl"] = "";
    data["owl"] = "<!--";
    data["ox"] = "";
    data["ox"] = "//";
    data["oxh"] = "";
    data["oxh"] = "//";
    data["oxo"] = "";
    data["oxo"] = "//";
    data["oxygene"] = "";
    data["oz"] = "";
    data["oz"] = "<!--";
    data["p"] = "";
    data["p"] = "#";
    data["p4"] = "";
    data["p6"] = "";
    data["p6l"] = "";
    data["p6l"] = "#";
    data["p6m"] = "";
    data["p6m"] = "#";
    data["p8"] = "";
    data["pac"] = "";
    data["pan"] = "";
    data["parrot"] = "";
    data["pas"] = "";
    data["pascal"] = "";
    data["pasm"] = "";
    data["pat"] = "";
    data["patch"] = "";
    data["pb"] = "";
    data["pbi"] = "";
    data["pbt"] = "";
    data["pbtxt"] = "";
    data["PcbDoc"] = "";
    data["PcbDoc"] = "#";
    data["pck"] = "";
    data["pcss"] = "";
    data["pd"] = "";
    data["pd_lua"] = "";
    data["pde"] = "";
    data["pegjs"] = "";
    data["pegjs"] = "//";
    data["pep"] = "";
    data["per"] = "";
    data["perl"] = "";
    data["pfa"] = "";
    data["pgsql"] = "";
    data["ph"] = "";
    data["php"] = "";
    data["php"] = "//";
    data["php_cs"] = "";
    data["php3"] = "";
    data["php3"] = "#";
    data["php4"] = "";
    data["php4"] = "#";
    data["php5"] = "";
    data["php5"] = "#";
    data["phps"] = "";
    data["phps"] = "#";
    data["phpt"] = "";
    data["phpt"] = "#";
    data["phtml"] = "";
    data["pic"] = "";
    data["pig"] = "";
    data["pike"] = "";
    data["pir"] = "";
    data["pkb"] = "";
    data["pkgproj"] = "";
    data["pkl"] = "";
    data["pks"] = "";
    data["pl"] = "";
    data["pl"] = "#";
    data["pl6"] = "";
    data["pl6"] = "#";
    data["plantuml"] = "";
    data["plb"] = "";
    data["plist"] = "";
    data["plist"] = "//";
    data["plot"] = "";
    data["pls"] = "";
    data["plsql"] = "";
    data["plt"] = "";
    data["pluginspec"] = "";
    data["pluginspec"] = "#";
    data["plx"] = "";
    data["pm"] = "";
    data["pm"] = "#";
    data["pm"] = "#";
    data["pm6"] = "";
    data["pm6"] = "#";
    data["pml"] = "";
    data["pmod"] = "";
    data["po"] = "";
    data["pod"] = "";
    data["pod6"] = "";
    data["podsl"] = "";
    data["podspec"] = "";
    data["podspec"] = "#";
    data["pogo"] = "";
    data["pony"] = "";
    data["postcss"] = "";
    data["pot"] = "";
    data["pov"] = "";
    data["powershell"] = "#";
    data["pp"] = "";
    data["pprx"] = "";
    data["pprx"] = "/*";
    data["pr"] = "//";
    data["prawn"] = "";
    data["prawn"] = "#";
    data["prc"] = "";
    data["prefab"] = "";
    data["prefab"] = "#";
    data["prefs"] = "";
    data["prettierignore"] = "";
    data["prg"] = "";
    data["prg"] = "//";
    data["pri"] = "";
    data["pri"] = "#";
    data["prisma"] = "";
    data["PrjPCB"] = "";
    data["PrjPCB"] = "#";
    data["pro"] = "";
    data["profile"] = "";
    data["proj"] = "";
    data["project"] = "";
    data["prolog"] = "";
    data["properties"] = "";
    data["props"] = "";
    data["proto"] = "";
    data["prw"] = "";
    data["prw"] = "//";
    data["pryrc"] = "";
    data["ps"] = "";
    data["ps1"] = "";
    data["ps1xml"] = "";
    data["psc"] = "";
    data["psc1"] = "";
    data["psd1"] = "";
    data["psgi"] = "";
    data["psm1"] = "";
    data["pt"] = "";
    data["pub"] = "";
    data["pug"] = "";
    data["puml"] = "";
    data["purs"] = "";
    data["pwn"] = "";
    data["pxd"] = "";
    data["pxi"] = "";
    data["py"] = "";
    data["py"] = "#";
    data["py3"] = "";
    data["pyde"] = "";
    data["pyi"] = "";
    data["pyp"] = "";
    data["pyt"] = "";
    data["pytb"] = "";
    data["python"] = "#";
    data["pyw"] = "";
    data["pyx"] = "";
    data["q sharp"] = "//";
    data["q"] = "";
    data["q"] = "//";
    data["qasm"] = "";
    data["qasm"] = "#";
    data["qbs"] = "";
    data["qbs"] = "//";
    data["ql"] = "";
    data["qll"] = "";
    data["qmd"] = "";
    data["qmd"] = "<!--";
    data["qml"] = "";
    data["qml"] = "//";
    data["qs"] = "";
    data["qs"] = "//";
    data["r"] = "";
    data["r"] = "#";
    data["r2"] = "";
    data["r2"] = ";";
    data["r3"] = "";
    data["r3"] = ";";
    data["rabl"] = "";
    data["rabl"] = "#";
    data["rake"] = "";
    data["rake"] = "#";
    data["raku"] = "";
    data["raku"] = "#";
    data["rakumod"] = "";
    data["rakumod"] = "#";
    data["raml"] = "";
    data["raml"] = "#";
    data["raw"] = "";
    data["razor"] = "";
    data["rb"] = "";
    data["rb"] = "#";
    data["rbbas"] = "";
    data["rbfrm"] = "";
    data["rbi"] = "";
    data["rbi"] = "#";
    data["rbmnu"] = "";
    data["rbres"] = "";
    data["rbtbar"] = "";
    data["rbuild"] = "";
    data["rbuild"] = "#";
    data["rbuistate"] = "";
    data["rbw"] = "";
    data["rbw"] = "#";
    data["rbx"] = "";
    data["rbx"] = "#";
    data["rbxs"] = "";
    data["rchit"] = "";
    data["rchit"] = "//";
    data["rd"] = "";
    data["rdf"] = "";
    data["rdoc"] = "";
    data["re"] = "";
    data["re"] = "//";
    data["reb"] = "";
    data["reb"] = ";";
    data["rebol"] = "";
    data["rebol"] = ";";
    data["red"] = "";
    data["red"] = ";";
    data["reds"] = "";
    data["reds"] = ";";
    data["reek"] = "";
    data["reek"] = "#";
    data["reg"] = "";
    data["reg"] = ";";
    data["regex"] = "";
    data["regexp"] = "";
    data["rego"] = "";
    data["rego"] = "#";
    data["rei"] = "";
    data["rei"] = "//";
    data["religo"] = "";
    data["religo"] = "//";
    data["res"] = "";
    data["res"] = "//";
    data["rest"] = "";
    data["resx"] = "";
    data["rex"] = "";
    data["rex"] = "/*";
    data["rexx"] = "";
    data["rexx"] = "/*";
    data["rg"] = "";
    data["rhtml"] = "";
    data["ring"] = "";
    data["ring"] = "/*";
    data["riot"] = "";
    data["riot"] = "<!--";
    data["rkt"] = "";
    data["rktd"] = "";
    data["rktl"] = "";
    data["rl"] = "";
    data["rmd"] = "";
    data["rmd"] = "<!--";
    data["rmiss"] = "";
    data["rmiss"] = "//";
    data["rnh"] = "";
    data["rno"] = "";
    data["robot"] = "";
    data["robot"] = "#";
    data["rockspec"] = "";
    data["roff"] = "";
    data["ronn"] = "";
    data["rpgle"] = "";
    data["Rprofile"] = "";
    data["rpy"] = "";
    data["rpy"] = "#";
    data["rq"] = "";
    data["rq"] = "#";
    data["rs"] = "";
    data["rs"] = "//";
    data["rsc"] = "";
    data["rsc"] = "//";
    data["rsh"] = "";
    data["rss"] = "";
    data["rst"] = "";
    data["rsx"] = "";
    data["rsx"] = "#";
    data["rtf"] = "";
    data["ru"] = "";
    data["ru"] = "#";
    data["ruby"] = "";
    data["ruby"] = "#";
    data["rust"] = "//";
    data["rviz"] = "";
    data["rviz"] = "#";
    data["s"] = "";
    data["s"] = ";";
    data["sage"] = "";
    data["sage"] = "#";
    data["sagews"] = "";
    data["sagews"] = "#";
    data["sas"] = "";
    data["sas"] = "/*";
    data["sass"] = "";
    data["sass"] = "//";
    data["sats"] = "";
    data["sbt"] = "";
    data["sbt"] = "//";
    data["sc"] = "";
    data["sc"] = "//";
    data["scad"] = "";
    data["scad"] = "//";
    data["scala"] = "";
    data["scala"] = "//";
    data["scaml"] = "";
    data["scaml"] = "//";
    data["scd"] = "";
    data["sce"] = "";
    data["sce"] = "//";
    data["sch"] = "";
    data["sch"] = "<!--";
    data["SchDoc"] = "";
    data["SchDoc"] = "#";
    data["sci"] = "";
    data["sci"] = "//";
    data["scm"] = "";
    data["scm"] = ";";
    data["sco"] = "";
    data["scpt"] = "";
    data["scpt"] = "#";
    data["scrbl"] = "";
    data["scss"] = "";
    data["scss"] = "//";
    data["scxml"] = "";
    data["sed"] = "";
    data["sed"] = "#";
    data["self"] = "";
    data["service"] = "";
    data["service"] = "#";
    data["sexp"] = "";
    data["sfd"] = "";
    data["sfproj"] = "";
    data["sh-session"] = "";
    data["sh"] = "";
    data["sh"] = "#";
    data["shader"] = "";
    data["shader"] = "//";
    data["shader"] = "//";
    data["shell"] = "#";
    data["shellcheckrc"] = "";
    data["shen"] = "";
    data["shproj"] = "";
    data["sieve"] = "";
    data["sieve"] = "#";
    data["sig"] = "";
    data["simplecov"] = "";
    data["sj"] = "";
    data["sj"] = "//";
    data["sjs"] = "";
    data["sl"] = "";
    data["sl"] = "<!--";
    data["sld"] = "";
    data["sld"] = ";";
    data["slim"] = "";
    data["slim"] = "//";
    data["sln"] = "";
    data["sls"] = "";
    data["sls"] = "#";
    data["sma"] = "";
    data["smali"] = "";
    data["smali"] = "#";
    data["smk"] = "";
    data["sml"] = "";
    data["smt"] = "";
    data["smt"] = ";";
    data["smt2"] = "";
    data["smt2"] = ";";
    data["snap"] = "";
    data["snip"] = "";
    data["snip"] = "#";
    data["snippet"] = "";
    data["snippets"] = "";
    data["snippets"] = "#";
    data["sol"] = "";
    data["soy"] = "";
    data["sp"] = "";
    data["sp"] = "//";
    data["spacemacs"] = "";
    data["sparql"] = "";
    data["sparql"] = "#";
    data["spc"] = "";
    data["spec"] = "";
    data["spec"] = "#";
    data["spin"] = "";
    data["sps"] = "";
    data["sps"] = ";";
    data["sqf"] = "";
    data["sqf"] = "//";
    data["sql"] = "";
    data["sql"] = "#";
    data["sqlrpgle"] = "";
    data["sra"] = "";
    data["srdf"] = "";
    data["srt"] = "";
    data["srt"] = ";";
    data["sru"] = "";
    data["srw"] = "";
    data["ss"] = "";
    data["ss"] = ";";
    data["ssjs"] = "";
    data["sss"] = "";
    data["sss"] = "//";
    data["st"] = "";
    data["stan"] = "";
    data["stan"] = "#";
    data["sthlp"] = "";
    data["sthlp"] = "//";
    data["ston"] = "";
    data["story"] = "";
    data["storyboard"] = "";
    data["stTheme"] = "";
    data["sty"] = "";
    data["styl"] = "";
    data["styl"] = "//";
    data["stylelintignore"] = "";
    data["sublime-build"] = "";
    data["sublime-commands"] = "";
    data["sublime-completions"] = "";
    data["sublime-keymap"] = "";
    data["sublime-macro"] = "";
    data["sublime-menu"] = "";
    data["sublime-mousemap"] = "";
    data["sublime-project"] = "";
    data["sublime-settings"] = "";
    data["sublime-snippet"] = "";
    data["sublime-syntax"] = "";
    data["sublime-syntax"] = "#";
    data["sublime-theme"] = "";
    data["sublime-workspace"] = "";
    data["sublime_metrics"] = "";
    data["sublime_session"] = "";
    data["sv"] = "";
    data["sv"] = "//";
    data["svelte"] = "";
    data["svelte"] = "<!--";
    data["svg"] = "";
    data["svg"] = "<!--";
    data["svh"] = "";
    data["svh"] = "//";
    data["swift"] = "";
    data["swift"] = "//";
    data["syntax"] = "";
    data["syntax"] = "#";
    data["t"] = "";
    data["t"] = "#";
    data["tab"] = "";
    data["tab"] = "#";
    data["tac"] = "";
    data["talon"] = "";
    data["talon"] = "#";
    data["targets"] = "";
    data["tcc"] = "";
    data["tcc"] = "//";
    data["tcl"] = "";
    data["tcl"] = "#";
    data["tcsh"] = "";
    data["tcsh"] = "#";
    data["te"] = "";
    data["te"] = "#";
    data["tea"] = "";
    data["tea"] = "//";
    data["tern-config"] = "";
    data["tern-project"] = "";
    data["tesc"] = "";
    data["tesc"] = "//";
    data["tese"] = "";
    data["tese"] = "//";
    data["tex"] = "";
    data["texi"] = "";
    data["texinfo"] = "";
    data["textile"] = "";
    data["textproto"] = "";
    data["tf"] = "";
    data["tfstate"] = "";
    data["tfvars"] = "";
    data["thor"] = "";
    data["thor"] = "#";
    data["thrift"] = "";
    data["thrift"] = "#";
    data["thy"] = "";
    data["tl"] = "";
    data["tl"] = "//";
    data["tla"] = "";
    data["tm"] = "";
    data["tm"] = "#";
    data["tm_properties"] = "";
    data["tmac"] = "";
    data["tmCommand"] = "";
    data["tml"] = "";
    data["tmLanguage"] = "";
    data["tmPreferences"] = "";
    data["tmSnippet"] = "";
    data["tmTheme"] = "";
    data["tmux"] = "";
    data["tmux"] = "#";
    data["toc"] = "";
    data["toml"] = "";
    data["toml"] = "#";
    data["tool"] = "";
    data["tool"] = "#";
    data["topojson"] = "";
    data["tpb"] = "";
    data["tpl"] = "";
    data["tpl"] = "<!--";
    data["tpp"] = "";
    data["tpp"] = "//";
    data["tps"] = "";
    data["trg"] = "";
    data["ts"] = "";
    data["ts"] = "//";
    data["tst"] = "";
    data["tst"] = "#";
    data["tsv"] = "";
    data["tsv"] = "#";
    data["tsx"] = "";
    data["tsx"] = "//";
    data["ttl"] = "";
    data["ttl"] = "#";
    data["tu"] = "";
    data["tu"] = "/*";
    data["twig"] = "";
    data["twig"] = "<!--";
    data["txi"] = "";
    data["txl"] = "";
    data["txt"] = "";
    data["typescript"] = "//";
    data["uc"] = "";
    data["uc"] = "//";
    data["udf"] = "";
    data["udf"] = "#";
    data["udo"] = "";
    data["ui"] = "";
    data["unity"] = "";
    data["unity"] = "#";
    data["uno"] = "";
    data["uno"] = "//";
    data["upc"] = "";
    data["upc"] = "//";
    data["ur"] = "";
    data["urdf"] = "";
    data["url"] = "";
    data["urs"] = "";
    data["ux"] = "";
    data["v"] = "";
    data["v"] = "//";
    data["vala"] = "";
    data["vala"] = "//";
    data["vapi"] = "";
    data["vapi"] = "//";
    data["vark"] = "";
    data["vb"] = "";
    data["vba"] = "";
    data["vbhtml"] = "";
    data["vbproj"] = "";
    data["vbs"] = "";
    data["vcl"] = "";
    data["vcl"] = "#";
    data["vcxproj"] = "";
    data["vdf"] = "";
    data["vdf"] = "//";
    data["veo"] = "";
    data["veo"] = "//";
    data["vercelignore"] = "";
    data["vert"] = "";
    data["vert"] = "//";
    data["vh"] = "";
    data["vh"] = "//";
    data["vhd"] = "--";
    data["vhd"] = "";
    data["vhdl"] = "--";
    data["vhdl"] = "";
    data["vhf"] = "--";
    data["vhf"] = "";
    data["vhi"] = "--";
    data["vhi"] = "";
    data["vho"] = "--";
    data["vho"] = "";
    data["vhost"] = "";
    data["vhost"] = "#";
    data["vhost"] = "#";
    data["vhs"] = "--";
    data["vhs"] = "";
    data["vht"] = "--";
    data["vht"] = "";
    data["vhw"] = "--";
    data["vhw"] = "";
    data["view"] = "";
    data["vim"] = "";
    data["vimrc"] = "";
    data["viper"] = "";
    data["viw"] = "";
    data["viw"] = "#";
    data["vmb"] = "";
    data["volt"] = "";
    data["volt"] = "//";
    data["vrx"] = "";
    data["vrx"] = "//";
    data["vscodeignore"] = "";
    data["vsh"] = "";
    data["vsh"] = "//";
    data["vshader"] = "";
    data["vshader"] = "//";
    data["vsixmanifest"] = "";
    data["vssettings"] = "";
    data["vstemplate"] = "";
    data["vtt"] = "";
    data["vue"] = "";
    data["vue"] = "<!--";
    data["vw"] = "";
    data["vxml"] = "";
    data["vy"] = "";
    data["vy"] = "#";
    data["w"] = "";
    data["wast"] = "";
    data["wat"] = "";
    data["watchmanconfig"] = "";
    data["watchr"] = "";
    data["watchr"] = "#";
    data["wdl"] = "";
    data["wdl"] = "#";
    data["webapp"] = "";
    data["webidl"] = "";
    data["webidl"] = "//";
    data["webmanifest"] = "";
    data["weechatlog"] = "";
    data["wgetrc"] = "";
    data["wgetrc"] = "#";
    data["wiki"] = "";
    data["wiki"] = "<!--";
    data["wikitext"] = "";
    data["wikitext"] = "<!--";
    data["wisp"] = "";
    data["wisp"] = ";";
    data["wixproj"] = "";
    data["wl"] = "";
    data["wlk"] = "";
    data["wlk"] = "//";
    data["wlt"] = "";
    data["wlua"] = "";
    data["workbook"] = "";
    data["workflow"] = "";
    data["ws"] = "";
    data["ws"] = "//";
    data["wsdl"] = "";
    data["wsf"] = "";
    data["wsgi"] = "";
    data["wxi"] = "";
    data["wxl"] = "";
    data["wxs"] = "";
    data["x"] = "";
    data["x10"] = "";
    data["x10"] = "//";
    data["x3d"] = "";
    data["x68"] = "";
    data["xacro"] = "";
    data["xaml"] = "";
    data["xbm"] = "";
    data["xbm"] = "//";
    data["xc"] = "";
    data["xc"] = "//";
    data["XCompose"] = "";
    data["xht"] = "";
    data["xhtml"] = "";
    data["xi"] = "";
    data["xib"] = "";
    data["xlf"] = "";
    data["xliff"] = "";
    data["xm"] = "";
    data["xmi"] = "";
    data["xml"] = "";
    data["xml"] = "<!--";
    data["xmp"] = "";
    data["xojo_code"] = "";
    data["xojo_code"] = "//";
    data["xojo_menu"] = "";
    data["xojo_menu"] = "//";
    data["xojo_report"] = "";
    data["xojo_report"] = "//";
    data["xojo_script"] = "";
    data["xojo_script"] = "//";
    data["xojo_toolbar"] = "";
    data["xojo_toolbar"] = "//";
    data["xojo_window"] = "";
    data["xojo_window"] = "//";
    data["xpl"] = "";
    data["xpm"] = "";
    data["xpm"] = "//";
    data["xproc"] = "";
    data["xproj"] = "";
    data["xpy"] = "";
    data["xq"] = "";
    data["xq"] = "<!--";
    data["xql"] = "";
    data["xql"] = "<!--";
    data["xqm"] = "";
    data["xqm"] = "<!--";
    data["xquery"] = "";
    data["xquery"] = "<!--";
    data["xqy"] = "";
    data["xqy"] = "<!--";
    data["xrl"] = "";
    data["xs"] = "";
    data["xs"] = "//";
    data["xsd"] = "";
    data["xsh"] = "";
    data["xsh"] = "#";
    data["xsjs"] = "";
    data["xsjslib"] = "";
    data["xsl"] = "";
    data["xsl"] = "<!--";
    data["xslt"] = "";
    data["xslt"] = "<!--";
    data["xsp-config"] = "";
    data["xsp"] = "";
    data["xspec"] = "";
    data["xtend"] = "";
    data["xul"] = "";
    data["xzap"] = "";
    data["xzap"] = ";";
    data["y"] = "";
    data["y"] = "//";
    data["yacc"] = "";
    data["yacc"] = "//";
    data["yaml-tmlanguage"] = "";
    data["yaml-tmlanguage"] = "#";
    data["yaml"] = "";
    data["yaml"] = "#";
    data["yang"] = "";
    data["yang"] = "//";
    data["yap"] = "";
    data["yar"] = "";
    data["yar"] = "//";
    data["yara"] = "";
    data["yara"] = "//";
    data["yasnippet"] = "";
    data["yml"] = "";
    data["yml"] = "#";
    data["yrl"] = "";
    data["yy"] = "";
    data["yyp"] = "";
    data["zap"] = "";
    data["zap"] = ";";
    data["zcml"] = "";
    data["zeek"] = "";
    data["zeek"] = "#";
    data["zep"] = "";
    data["zep"] = "//";
    data["zig"] = "";
    data["zig"] = "//";
    data["zil"] = "";
    data["zil"] = ";";
    data["zimpl"] = "";
    data["zlogin"] = "";
    data["zlogout"] = "";
    data["zmpl"] = "";
    data["zone"] = "";
    data["zpl"] = "";
    data["zprofile"] = "";
    data["zs"] = "";
    data["zs"] = "//";
    data["zsh-theme"] = "";
    data["zsh-theme"] = "#";
    data["zsh"] = "";
    data["zsh"] = "#";
    data["zshenv"] = "";
    data["zshrc"] = "";

    # URL encoding
    for (i = 0; i < 256; i++) { 
        c2p[sprintf("%c", i)] = sprintf("%%%02X", i);
    }

    for (i = 48; i < 58; i++) { 
        c2p[sprintf("%c", i)] = sprintf("%c", i);
    }

    for (i = 65; i < 91; i++) {
        c2p[sprintf("%c", i)] = sprintf("%c", i);
    }

    for (i = 97; i < 123; i++) {
        c2p[sprintf("%c", i)] = sprintf("%c", i);
    }
    
    c2p["-"] = "-";
    c2p["."] = ".";
    c2p["_"] = "_";
    c2p["%"] = "%25";
    c2p["+"] = "%2B";
    c2p[" "] = "%20";
    c2p["/"] = "%2F";
    c2p["?"] = "%3F";
    c2p["#"] = "%23";
    c2p["&"] = "%26";
    c2p["="] = "%3D";
    c2p[";"] = "%3B";
    c2p[":"] = "%3A";
    c2p["@"] = "%40";
    c2p["$"] = "%24";
    c2p["\""] = "%22";
    c2p["<"] = "%3C";
    c2p[">"] = "%3E";
    c2p["#"] = "%23";
    c2p["{"] = "%7B";
    c2p["}"] = "%7D";
    c2p["|"] = "%7C";
    c2p["\\"] = "%5C";
    c2p["^"] = "%5E";
    c2p["~"] = "%7E";
    c2p["["] = "%5B";
    c2p["]"] = "%5D";
    c2p["`"] = "%60";
    c2p["'"] = "%27";
}


function command_runner(path, start, end, comment_word) {
    # Function that reads a program file and outputs the code between specified ranges; 
    # if start and end are blank, the entire source code is output as is

    if (start != " " && end != " ") {
        cmd = sprintf("awk /%s/,/%s/'{print $0}' %s", start, end, path);
        comment_out_start = sprintf("%s %s", comment_word, start);
        comment_out_end = sprintf("%s %s", comment_word, end);

        while (cmd | getline line) {
            if (line != comment_out_start && line != comment_out_end) {
                print(line);
            }
        }
    } else {
        # For when you want to expand the entire contents of a file into code blocks
        # Example: ```python:./main.py: : ```
        #     This is achieved by writing a whitespace in the "<start>" and "<end>" sections.
        cmd = sprintf("awk '{print $0}' %s", path)
        while (cmd | getline line) {
            print(line);
        }
    }

    close(cmd);
}


function command_runner_for_playground(path, start, end, comment_word, url_word) {
    # Extension of normal command_runner to output playground url
    OFS = "";
    ORS = "";

    cmd = sprintf("awk /%s/,/%s/'{print $0}' %s", start, end, path);
    comment_out_start = sprintf("%s %s", comment_word, start);
    comment_out_end = sprintf("%s %s", comment_word, end);

    print(sprintf("\n[%s](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&code=", url_word));
    while (cmd | getline line) {
        print("%0A");
        for (i = 1; i <= length(line); i++) {
            if (line != comment_out_start && line != comment_out_end) {
                print(c2p[substr(line, i, 1)]);
            }
        }
    }
    print(")\n");
    close(cmd);

    OFS = " ";
    ORS = "\n";
}


function line_counter(cmd) {
    # Function to count the number of lines in a file and return the value
    line_count = 0;
    while (cmd | getline line) {
        line_count += 1;
    }
    close(cmd);
    return line_count;
}


function table_of_contents_generator(file_path, url_prefix, start_heading_number, end_heading_number) {
    #
    # | Prefix | Number of hash sign | Indents | 
    # | ------ | ------------------- | ------- |
    # | ##     | 2                   | 0       |
    # | ###    | 3                   | 2       |
    # | ####   | 4                   | 4       |
    # | #####  | 5                   | 6       |
    # | ###### | 6                   | 8       |
    #
    # Equation:
    # 
    #         (|1 - x| - 1) + (x - y)
    #
    #     x: Number of hash sign(#)
    #     y: Number of standard headings
    #
    #
    # Example:
    # 
    #     y = 2
    #
    #     Example1: ## h2
    #      
    #         (|1 - 2| - 1) + (2 - 2) = (|-1| - 1) + 0
    #                                 = (1 - 1) + 0
    #                                 = 0 + 0
    #                                 = 0
    #
    #     Example2: ##### h5
    #
    #         (|1 - 5| - 1) + (5 - 2) = (|-4| - 1) + 3
    #                                 = (4 - 1) + 3
    #                                 = 3 + 3
    #                                 = 6
    #

    ORS = "";

    cmd = sprintf("awk '/^#{1,6}/ {print $0}' %s", file_path);

    # Define the number for relative comparison when the standard is 2
    base_value_correction = (abs(1 - (start_heading_number + 1)) - 1) + (start_heading_number + 1) - 2;

    # Output lines matching heading(#)
    while (cmd | getline line) {
        split(line, arr, " ");    # "arr[1]" has a minimum of 2 and a maximum of 6 consecutive "#"
        sub("#{1,6} ", "", line); # Example: "### h3" ---> "h3"

        for_url_string = gensub(" ", "-", "g", line); # Convert " " to "-" to expand the headline string as-is as a url

        # Heading 1 is the title, so it is not included in the table of contents
        if (length(arr[1]) > 1) {
            hash_sign_length = length(arr[1]);
            
            if (start_heading_number - 1 < hash_sign_length && hash_sign_length < end_heading_number + 1) {
                hash_sign_length = (abs(1 - hash_sign_length) - 1) + hash_sign_length - base_heading_number;
                
                # Indentation output
                for (i = 0; i < hash_sign_length - base_value_correction; i++) {
                    print(" ");
                }

                # Output link string in list format
                print(sprintf("- [%s](%s%s)\n", line, url_prefix, tolower(for_url_string)));
            }
        }
    }
    close(cmd);

    ORS = "\n";
}


function abs(value) {
    # Functions that return absolute values
    value += 0;
    return value < 0 ? -value : value;
}


function command_runner_for_expanding_data(type, file_path, summary_word) {
    OFS = "";
    ORS = "";
    
    # To generate an error if the type is wrong
    if (type == "li" || type == "ol") {
        cmd = sprintf("awk '{print $0}' %s", file_path);
        line_count = 1; # Counter variable for "ol"

        if (summary_word != "") {
            print(sprintf("<details>\n  <summary>%s</summary>\n\n", summary_word));
        }

        while (cmd | getline line) {
            switch (type) {
                case "li":
                    print(sprintf("- %s\n", line));
                    break;
                case "ol":
                    print(sprintf("%d. %s\n", line_count, line));
                    line_count += 1;
                    break;
            }
        }
        close(cmd);

        # Output the end tag of "<details>" when "summary_word" is entered
        if (summary_word != "") {
            print("\n</details>\n");
        }
    } else {
        print("ERROR: Type does not match\n\n");
    }

    OFS = " ";
    ORS = "\n";
}


# Create a table of contents from a heading
# Notation: -_|<target-file>|<url-string>[|heading-start[|heading-end]]
/-_\|.+\|.+/ {
    split($0, information, "|");
    information_length = length(information);

    # Implementation to be tolerant of the presence of "|" at the end of lines
    if (information_length == 3 || information_length == 4) {
        table_of_contents_generator(information[2], information[3], 2, 6);
    } else if (information_length == 5 || information_length == 6) {
        table_of_contents_generator(information[2], information[3], information[4], information[5]);
    }

    next;
}


# Code block generation from program loading
# Notation: ```<language>:<file-path>:<start>:<end>```
/```.+:.+:.+:.+```/ && !/```.+\|.+```/ {
    split($0, code_block, ":");
    
    count = 0;
    language = code_block[1];
    file_path = code_block[2];
    start = code_block[3];
    end = code_block[4];
    cmd = sprintf("bash -c \"if [[ -e %s ]]; then echo true; else echo false; fi;\"", file_path);

    sub("```", "", language);
    sub("```", "", end);

    # For files that do not require an extension
    if (language == " ") {
        print(sprintf("```%s", file_path));
    } else {
        print(sprintf("```%s:%s", language, file_path));
    }

    if (cmd | getline line) {
        if (line == "true") {
            # For playground
            if (language == "rust" && length(code_block) == 5) {
                sub("```", "", code_block[5]);
                
                global_file_path = file_path;
                global_start = start;
                global_end = end;
                global_comment_word = data[language];
                global_url_word = code_block[5];
                
                count += 1;
            }

            # Stdout source code
            command_runner(file_path, start, end, data[language]);
        } else {
            print("ERROR: No such file");
        }
    }
    close(cmd);
    print("```");

    start = "";
    end = "";

    # If the counter variable count is greater than 1, that is, if it is a notation for a playground url
    if (count) {
        command_runner_for_playground(\
            global_file_path,
            global_start,
            global_end,
            global_comment_word,
            global_url_word\
        );
    }

    next;
}


# Code block operation
# Notation: ```<language>|<pattern> <pattern>...```
/```.+\|(.+\..+:.+:.+?){2,}```/ {
    split($0, code_block_for_operation, "|");
    
    language = code_block_for_operation[1];
    targets = code_block_for_operation[2];

    sub("```", "", language);
    split(targets, target_list, " ");

    print(sprintf("```%s", language));
    for (i = 1; i <= length(target_list); i++) {
        sub("```", "", target_list[i]);
        split(target_list[i], target, ":");

        file_path = target[1];
        start = target[2];
        end = target[3];
        cmd = sprintf("bash -c \"if [[ -e %s ]]; then echo true; else echo false; fi;\"", file_path);

        if (cmd | getline line) {
            if (line == "true") {
                command_runner(file_path, start, end, data[language]);
            } else {
                print("ERROR: File does not exist");
            }
        }
        close(cmd);

        if (i != length(target_list)) {
            print("");
        }
    }
    print("```");
    next;
}


# Visuallization of directories by tree structure
# Notation: ```tree:<directory-path>```
/```tree:.+```/ {
    split($0, splited, ":");
    path = gensub("```", "", "g", splited[2]);

    cmd = sprintf("tree %s", path);
    line_count = line_counter(cmd);

    print("```");
    while (cmd | getline line) {
        if (line_count > 2) {
            print(line);
            line_count -= 1;
        }
    }
    close(cmd);
    print("```");

    next;
}


# Execution of commands in base file
/^!\s.+/ {
    # TODO: use substr
    sub("! ", "", $0);
    cmd = $0;
    while (cmd | getline line) {
        print(line);
    }
    close(cmd);
}


# Expanding data in a file
# Notation: -|<type>|<file-path>[|summary-word]
/\-\|.+\|.+/ {
    split($0, arr, "|");
    arr_length = length(arr);

    if (arr_length == 3) {
        # If you put "|" at the end of a line, it is not enclosed in "<details>"
        command_runner_for_expanding_data(arr[2], arr[3], "");
    } else if (arr_length == 4) {
        command_runner_for_expanding_data(arr[2], arr[3], arr[4]);
    }

    next;
}


# If the notation does not match
{   
    print $0;
}
