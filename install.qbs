import qbs
import qbs.File
import qbs.FileInfo
import qbs.TextFile

Project {
  id: main
  property string releaseType

  Probe {
    id: info
    property string fileName: "info.json"
    property var data
    configure: {
      // making sure the info file exists
      if (!File.exists(fileName)){
        throw new Error("Cannot find: " + fileName)
      }

      // parsing info contents
      data = JSON.parse(new TextFile(fileName).readAll())
    }
  }

  Application {
    Group {
      qbs.installPrefix: {

        // building the target location
        targetPrefix = FileInfo.joinPaths(info.data.type, info.data.name, info.data.version)

        // making sure to never override a production release
        targetFullPath = FileInfo.joinPaths(qbs.installRoot, targetPrefix)
        if (main.releaseType == "production" && File.exists(targetFullPath)) {
          throw new Error("Cannot override an existent production release: " + targetFullPath)
        }
        console.info("Target: " + targetFullPath)

        return targetPrefix
      }

      Group {
          name: "Main source files"
          files: [
            "src/**"
          ]
          excludeFiles: []
          qbs.installSourceBase: "./src"
          qbs.install: true
      }

      Group {
          name: "Info File"
          files: [
            "info.json"
          ]
          qbs.install: true
          qbs.installSourceBase: "./"
      }
    }
  }
}
