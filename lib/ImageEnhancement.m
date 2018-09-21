function enhanced_img = ImageEnhancement(normalized_iris)
enhanced_img = histeq(normalized_iris, 256);
end
