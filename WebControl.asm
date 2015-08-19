
_SPI_Ethernet_UserTCP:

;WebControl.c,54 :: 		unsigned int reqLength, TEthPktFlags *flags)
;WebControl.c,57 :: 		for(len=0; len<10; len++)getRequest[len]=SPI_Ethernet_getByte();
	CLRF        SPI_Ethernet_UserTCP_Len_L0+0 
	CLRF        SPI_Ethernet_UserTCP_Len_L0+1 
L_SPI_Ethernet_UserTCP0:
	MOVLW       0
	SUBWF       SPI_Ethernet_UserTCP_Len_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP11
	MOVLW       10
	SUBWF       SPI_Ethernet_UserTCP_Len_L0+0, 0 
L__SPI_Ethernet_UserTCP11:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP1
	MOVLW       _getRequest+0
	ADDWF       SPI_Ethernet_UserTCP_Len_L0+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+0 
	MOVLW       hi_addr(_getRequest+0)
	ADDWFC      SPI_Ethernet_UserTCP_Len_L0+1, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+1 
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVFF       FLOC__SPI_Ethernet_UserTCP+0, FSR1
	MOVFF       FLOC__SPI_Ethernet_UserTCP+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      SPI_Ethernet_UserTCP_Len_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_Len_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP0
L_SPI_Ethernet_UserTCP1:
;WebControl.c,58 :: 		getRequest[len]=0;
	MOVLW       _getRequest+0
	ADDWF       SPI_Ethernet_UserTCP_Len_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_getRequest+0)
	ADDWFC      SPI_Ethernet_UserTCP_Len_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;WebControl.c,59 :: 		if(memcmp(getRequest,"GET /",5))return(0);
	MOVLW       _getRequest+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_getRequest+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr1_WebControl+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr1_WebControl+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       5
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP3
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
L_SPI_Ethernet_UserTCP3:
;WebControl.c,61 :: 		if(!memcmp(getRequest+6,"TA",2))RD0_bit = ~ RD0_bit;
	MOVLW       _getRequest+6
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_getRequest+6)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr2_WebControl+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr2_WebControl+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       2
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP4
	BTG         RD0_bit+0, BitPos(RD0_bit+0) 
	GOTO        L_SPI_Ethernet_UserTCP5
L_SPI_Ethernet_UserTCP4:
;WebControl.c,62 :: 		else if(!memcmp(getRequest+6,"TB",2))RD1_bit = ~ RD1_bit;
	MOVLW       _getRequest+6
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_getRequest+6)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr3_WebControl+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr3_WebControl+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       2
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP6
	BTG         RD1_bit+0, BitPos(RD1_bit+0) 
L_SPI_Ethernet_UserTCP6:
L_SPI_Ethernet_UserTCP5:
;WebControl.c,64 :: 		if(localPort != 80)return(0);
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserTCP_localPort+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP12
	MOVLW       80
	XORWF       FARG_SPI_Ethernet_UserTCP_localPort+0, 0 
L__SPI_Ethernet_UserTCP12:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP7
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
L_SPI_Ethernet_UserTCP7:
;WebControl.c,65 :: 		Len = SPI_Ethernet_putConstString(HTTPheader);
	MOVLW       _HTTPheader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_HTTPheader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_HTTPheader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_Len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_Len_L0+1 
;WebControl.c,66 :: 		Len += SPI_Ethernet_putConstString(HTTPMimeTypeHTML);
	MOVLW       _HTTPMimeTypeHTML+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_HTTPMimeTypeHTML+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_HTTPMimeTypeHTML+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_Len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_Len_L0+1, 1 
;WebControl.c,67 :: 		Len += SPI_Ethernet_putString(StrtWebPage);
	MOVLW       _StrtWebPage+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_StrtWebPage+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        SPI_Ethernet_UserTCP_Len_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        SPI_Ethernet_UserTCP_Len_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_Len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_Len_L0+1 
;WebControl.c,68 :: 		return Len;
;WebControl.c,69 :: 		}
L_end_SPI_Ethernet_UserTCP:
	RETURN      0
; end of _SPI_Ethernet_UserTCP

_SPI_Ethernet_UserUDP:

;WebControl.c,76 :: 		unsigned int reqLength, TEthPktFlags *flags)
;WebControl.c,78 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
;WebControl.c,79 :: 		}
L_end_SPI_Ethernet_UserUDP:
	RETURN      0
; end of _SPI_Ethernet_UserUDP

_main:

;WebControl.c,84 :: 		void main()
;WebControl.c,86 :: 		ADCON1 = 0x0F;         // All AN pins as digital
	MOVLW       15
	MOVWF       ADCON1+0 
;WebControl.c,87 :: 		CMCON  = 0x07;         // Turn off comparators
	MOVLW       7
	MOVWF       CMCON+0 
;WebControl.c,88 :: 		TRISD = 0;             // Configure PORTD as output
	CLRF        TRISD+0 
;WebControl.c,89 :: 		PORTD = 0;
	CLRF        PORTD+0 
;WebControl.c,90 :: 		SPI1_Init();           // Initialize SPI module
	CALL        _SPI1_Init+0, 0
;WebControl.c,91 :: 		SPI_Ethernet_Init(MACAddr, IPAddr, 0x01); // Initialize Ethernet module
	MOVLW       _MACAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_mac+0 
	MOVLW       hi_addr(_MACAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_mac+1 
	MOVLW       _IPAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_ip+0 
	MOVLW       hi_addr(_IPAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_ip+1 
	MOVLW       1
	MOVWF       FARG_SPI_Ethernet_Init_fullDuplex+0 
	CALL        _SPI_Ethernet_Init+0, 0
;WebControl.c,93 :: 		while(1)                                                       // Do forever
L_main8:
;WebControl.c,95 :: 		SPI_Ethernet_doPacket();                                  // Process next received packet
	CALL        _SPI_Ethernet_doPacket+0, 0
;WebControl.c,96 :: 		}
	GOTO        L_main8
;WebControl.c,97 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
