def micro_hash_ucr (block):
	W = [0]*32
	i = 0
	j = 0
	H = [0]*3
	for i in range(0,32)
		if 0 <= i <= 15:
            		W[i] = block[i]

        	elif 16 <= i <= 31:
            		W[i] = W[i - 3] | W[i - 9] ^ W[i - 14]

	H[0] = 0x01
	H[1] = 0x89
	H[2] = 0xfe
	
	a = H[0]
	b = H[1]
	c = H[2]
	
	for j in range(0,32)
		if 0 <= j <= 16:
            		k = 0x99
            		x = (a ^ b) & 0xFF

            		a = (b ^ c) & 0xFF
            		b = (c << 4) & 0xFF
            		c = (x + k + w[j]) & 0xFF

        	elif 17 <= j <= 31:
            		k = 0xa1
            		x = (a | b) & 0xFF

            		a = (b ^ c) & 0xFF
            		b = (c << 4) & 0xFF
            		c = (x + k + w[j]) & 0xFF	
	
	H[0] = (H[0] + a) & 0xFF
	H[1] = (H[1] + b) & 0xFF
	H[2] = (H[2] + c) & 0xFF
return H		            		
