require './lib/caesar_cipher'

describe "caesar_cipher" do
  it "works on lowercase" do
    text = "hello world"
    expect(caesar_cipher(text, 1)).to eql("ifmmp xpsme")
  end

  it "works on uppercase" do
    text = "HELLO WORLD"
    expect(caesar_cipher(text, 1)).to eql("IFMMP XPSME")
  end

  it "ignores numbers and punctuation" do
    text = "Hello, World! 69 :)"
    expect(caesar_cipher(text, 1)).to eql("Ifmmp, Xpsme! 69 :)")
  end

  it "works on large numbers" do
    text = "Hello, World!"
    expect(caesar_cipher(text, 261)).to eql("Ifmmp, Xpsme!")
  end
  
  it "works on negative numbers" do
    text = "Hello, World!"
    expect(caesar_cipher(text, -10)).to eql("Xubbe, Mehbt!")
  end
end