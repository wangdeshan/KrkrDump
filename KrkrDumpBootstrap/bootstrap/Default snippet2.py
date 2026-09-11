import idaapi
import os

def get_string(addr):
  out = ""
  while True:
    if idaapi.get_byte(addr) != 0:
      out += chr(idaapi.get_byte(addr))
    else:
      break
    addr += 1
  return out

rv = ida_idd.regval_t()
ida_dbg.get_reg_val('ecx', rv)

addr = rv.ival+4

print ("rv.ival =>" + str(hex(addr)))
addr2 = ida_bytes.get_dword(addr)
print ("rv.ival =>" + hex(addr2))
#
ebx = get_reg_value("ebx")
#print(ebx)

askey =  get_string(addr2)
print(askey)