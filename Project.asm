;Car Parking System
;Bilal Ahmed Khalil 44926
;Nasir Hussian      43913

.386
.model flat,stdcall
.stack 4096
INCLUDE irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD

Vehicle Struct
    Number Dword ?
    TypeV Dword ?
Vehicle Ends


.data
    TVehicles Dword 2
    TCars Dword  1
    TBikes Dword 1
    TTruck Dword 0 
    Vi Vehicle 20 Dup(<0,0>)


    entermsg Byte "Press 1 to Display",0ah,0dh,"Press 2 to Search",0ah,0dh,"Press 3 to Insert",0ah,0dh,"Press 4 to Modify",0ah,0dh,"Press 5 to Check Out", 0ah,0dh,"Press 6 to DisplayAll",0ah,0dh,"Press 7 to Display Numbers",0ah,0dh,"Any other Number to exit :",0
    choice Dword ?
    typevi   Byte "Type :",0
    Numberv Byte "Number :",0
    car   Byte "Car     ",0
    bike  Byte "Bike    ",0
    truck Byte "Truck   ",0
    vehicleD Byte 0ah,0dh,"Vehicle :",0
    EnterNumber Byte 0ah,0dh,"Enter Vehicle Number :",0
    EnterType Byte 0ah,0dh,"Enter Vehicle Type ",0ah,0dh,"Press 1 for Car",0ah,0dh,"Press 2 for Bike",0ah,0dh,"Press 3 for Truck :",0
    errorv Byte "Vehicle Not Found",0
    EnterModify Byte 0ah,0dh,"Enter New Details",0
    Tv Byte 0ah,0dh,"Totals :",0
    again Byte 0ah,0dh,"Press 'y' to try again :"

.code
main PROC
LoopT:
    mov edx,0
    mov esi,0
    call clrscr
    mov esi, offset Vi
    mov [esi].Vehicle.Number,1122
    mov [esi].Vehicle.TypeV,1
    add esi, TYPE Vehicle
    mov [esi].Vehicle.Number,44926
    mov [esi].Vehicle.TypeV,2
    
    mov edx,offset entermsg
    call writeString
    call ReadInt
    mov choice,eax
    cmp choice,1
    je DisplayLabel
    cmp choice,2
    je SearchLabel
    cmp choice,3
    je InputVLabel
    cmp choice,4
    je ModifyLabel
    cmp choice,5
    je CheckOutLabel
    cmp choice,6
    je DisplayAllLabel
        cmp choice,7
    je ShowTotals
    jmp exitl

DisplayLabel:
    call Display
    jmp exitl

SearchLabel:
    call Search
    jmp exitl

InputVLabel:
    call InsertV
    jmp exitl

ModifyLabel:
    call Modify
    jmp exitl

CheckOutLabel:
    call CheckOut
    jmp exitl

DisplayAllLabel:
    call DisplayAll
    jmp exitl

ShowTotalsLable:
call ShowTotals

exitl:
mov edx,offset again
call writeString
call ReadChar
cmp al,'y'
je LoopT
cmp al,'Y'
je LoopT
    INVOKE ExitProcess,0
main ENDP





Display PROC
mov edx, offset EnterNumber
    call WriteString
    call ReadInt

    mov esi, offset Vi
    mov ecx, 20
SearchVehicle:
    cmp [esi].Vehicle.Number, eax
    je VehicleFound
    add esi, TYPE Vehicle
    loop SearchVehicle

    jmp VehicleNotFound

VehicleFound:
    call crlf
    mov edx, offset Numberv
    call WriteString
    mov eax, [esi].Vehicle.Number
    call WriteDec
    call crlf
    mov edx, offset typevi
    call WriteString
    cmp [esi].Vehicle.TypeV, 1
    je PCar
    cmp [esi].Vehicle.TypeV, 2
    je PBike
    cmp [esi].Vehicle.TypeV, 3
    je PTruck
    jmp DEnd

PCar:
    mov edx, offset car
    call WriteString
    jmp DEnd

PBike:
    mov edx, offset bike
    call WriteString
    jmp DEnd
PTruck:
    mov edx, offset truck
    call WriteString
    jmp DEnd

VehicleNotFound:
mov edx,offset errorv
call WriteString

DEnd:
    ret
    ret
Display ENDP



Search PROC
    mov edx, offset EnterNumber
    call WriteString
    call ReadInt

    mov esi, offset Vi
    mov ecx, 20
SearchVehicle:
    cmp [esi].Vehicle.Number, eax
    je VehicleFound
    add esi, TYPE Vehicle
    loop SearchVehicle

    jmp VehicleNotFound

VehicleFound:
    call crlf
    mov edx, offset Numberv
    call WriteString
    mov eax, [esi].Vehicle.Number
    call WriteDec
    call crlf
    mov edx, offset typevi
    call WriteString
    cmp [esi].Vehicle.TypeV, 1
    je PCar
    cmp [esi].Vehicle.TypeV, 2
    je PBike
    cmp [esi].Vehicle.TypeV, 3
    je PTruck
    jmp SearchEnd

PCar:
    mov edx, offset car
    call WriteString
    jmp SearchEnd

PBike:
    mov edx, offset bike
    call WriteString
    jmp SearchEnd
PTruck:
    mov edx, offset truck
    call WriteString
    jmp SearchEnd

VehicleNotFound:
mov edx,offset errorv
call WriteString

SearchEnd:
    ret
Search ENDP





InsertV PROC
    mov edx, offset EnterNumber
    call WriteString
    call ReadInt
    mov ebx, eax
    
    mov edx, offset EnterType
    call WriteString
    call ReadInt
    
    mov esi, offset Vi
    mov ecx, 20
FindEmptySlot:
    cmp [esi].Vehicle.Number, 0
    je FoundEmptySlot
    add esi, TYPE Vehicle
    loop FindEmptySlot
    jmp NoEmptySlotFound

FoundEmptySlot:
    mov [esi].Vehicle.Number, ebx
    mov [esi].Vehicle.TypeV, eax
    inc TVehicles
    cmp ebx, 1
    je IncCars
    cmp ebx, 2
    je IncBikes
    cmp ebx, 3
    je IncTrucks
    jmp InsertEnd

IncCars:
    inc TCars
    jmp InsertEnd

IncBikes:
    inc TBikes
    jmp InsertEnd

IncTrucks:
    inc TTruck
    jmp InsertEnd

NoEmptySlotFound:
InsertEnd:
    ret
InsertV ENDP


Modify PROC
    mov edx, offset EnterNumber
    call WriteString
    call ReadInt

    mov esi, offset Vi
    mov ecx, 20
FindVehicle:
    cmp [esi].Vehicle.Number, eax
    je VehicleFound
    add esi, TYPE Vehicle
    loop FindVehicle
    jmp VehicleNotFound

VehicleFound:
mov  edx,Offset EnterModify
    call WriteString
  mov edx, offset EnterNumber
    call WriteString
      call ReadInt
      mov ebx,eax
    mov edx, offset EnterType
    call WriteString
    call ReadInt
    mov [esi].Vehicle.TypeV, eax
        mov [esi].Vehicle.Number, ebx
    jmp ModifyEnd

VehicleNotFound:
mov edx,offset errorv
call WriteString
ModifyEnd:
    ret
Modify ENDP




CheckOut PROC
    mov edx, offset EnterNumber
    call WriteString
    call ReadInt

    mov esi, offset Vi
    mov ecx, 20
FindVehicleSlot:
    cmp [esi].Vehicle.Number, eax
    je FoundVehicleSlot
    add esi, TYPE Vehicle
    loop FindVehicleSlot

    jmp VehicleNotFound

FoundVehicleSlot:
    cmp [esi].Vehicle.TypeV, 1
    je Cars
    cmp [esi].Vehicle.TypeV, 2
    je Bikes
    cmp [esi].Vehicle.TypeV, 3
    je Trucks
    jmp DeleteS

Cars:
    dec TCars
    jmp DeleteS

Bikes:
    dec TBikes
    jmp DeleteS

Trucks:
    dec TTruck
    jmp DeleteS

DeleteS:
    mov [esi].Vehicle.Number, 0
    mov [esi].Vehicle.TypeV, 0
    dec TVehicles
    jmp CheckOutEnd

VehicleNotFound:
call crlf
mov edx,offset errorv
call WriteString
CheckOutEnd:
    ret
CheckOut ENDP






DisplayAll PROC
    mov ebx,1
    mov esi, offset Vi
    mov ecx, 20
    mov edx,0
DisplayLoop:
    cmp [esi].Vehicle.Number,0
    je EndDisplay
    call crlf
    mov edx, offset vehicleD
    call WriteString
    mov eax,ebx
    call writeDec
    call crlf
    inc ebx

    mov edx,offset Numberv
    call WriteString
    mov eax,[esi].Vehicle.Number
    call WriteDec
    call crlf
    cmp [esi].Vehicle.TypeV,1
    je carl
    cmp [esi].Vehicle.TypeV,2
    je bikel
    cmp [esi].Vehicle.TypeV,3
    je truckl

carl:
    mov edx,offset typevi
    call WriteString
    mov edx,offset car
    call WriteString
    jmp nextVehicle

bikel:
    mov edx,offset typevi
    call WriteString
    mov edx,offset bike
    call WriteString
    jmp nextVehicle

truckl:
    mov edx,offset typevi
    call WriteString
    mov edx,offset truck
    call WriteString
    jmp nextVehicle

nextVehicle:
    add esi, TYPE Vehicle
    dec ecx
    jnz DisplayLoop

EndDisplay:
    ret
DisplayAll ENDP

ShowTotals PROC
    call crlf
    mov edx,offset tv
    call WriteString
    mov edx, offset vehicleD
    call WriteString
    mov edx, offset TVehicles
    call WriteString
    mov eax, TVehicles
    call WriteDec
    call crlf

    mov edx, offset car
    call WriteString
    mov eax, TCars
    call WriteDec
    call crlf

    mov edx, offset bike
    call WriteString
    mov eax, TBikes
    call WriteDec
    call crlf

    mov edx, offset truck
    call WriteString
    mov eax, TTruck
    call WriteDec
    call crlf

    ret
ShowTotals ENDP



END main
