def caesar_cipher(string, shift_factor)
    # Adjust for large and/or negative shift factors 
    shift_factor %= 26
    shifted_string = ""

    string.each_byte do |char|
        if (char >= 65 && char <= 90)
            if (char + shift_factor) > 90
                shifted_string << (char + shift_factor - 26).chr
            else
                shifted_string << (char + shift_factor).chr
            end
        elsif (char >= 97 && char <= 122)
            if (char + shift_factor) > 122
                shifted_string << (char + shift_factor - 26).chr
            else
                shifted_string << (char + shift_factor).chr
            end
        else
            shifted_string << char.chr
        end
    end
    
    p shifted_string
end