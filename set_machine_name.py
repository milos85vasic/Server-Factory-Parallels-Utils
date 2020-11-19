#!/usr/bin/sudo python
import sys
import os
import xml.etree.ElementTree


def main():
    if len(sys.argv) > 1:
        image = sys.argv[1]
        file_path = image + "/config.pvs"
        if os.path.exists(file_path):
            with open(file_path, 'r') as fp:
                print(file_path + ": Configuration file")
                """
                    <ParallelsVirtualMachine dyn_lists="VirtualAppliance 0" schemaVersion="1.0">
                       
                       <Identification dyn_lists="">
                       
                          <VmName>CentOS Linux 8 xxx</VmName>
                       </Identification>
                    </ParallelsVirtualMachine
                """
                et = xml.etree.ElementTree.parse(file_path)
                for child in et.getroot().findall('.//Identification'):
                    for vm_name in child.findall('.//VmName'):
                        current_name = vm_name.text
                        new_name = current_name + "zzz"
                        vm_name.text = new_name
                        print(vm_name.text)
                        # et.write(file_path)

        else:
            print("ERROR: Configuration file was not found")
            sys.exit(1)

    else:
        print("No image path provided")
        sys.exit(1)


if __name__ == "__main__":
    main()
