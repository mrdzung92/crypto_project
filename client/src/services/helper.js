function formatNumber(num) {
    // Chuyển số thành chuỗi
    let str = num.toString();

    // Kiểm tra nếu số có phần thập phân
    if (str.indexOf('.') === -1) {
        return str + '.00'; // Nếu không có phần thập phân, thêm ".00"
    }

    // Tách phần nguyên và phần thập phân
    let parts = str.split('.');
    let integerPart = parts[0];
    let decimalPart = parts[1];

    // Kiểm tra độ dài phần thập phân
    if (decimalPart.length === 1) {
        return str + '0'; // Nếu chỉ có một chữ số thập phân, thêm "0"
    } else if (decimalPart.length === 0) {
        return str + '00'; // Nếu không có chữ số thập phân, thêm "00"
    } else {
        return str; // Nếu có hai chữ số thập phân trở lên, giữ nguyên
    }
}

// Xuất hàm
export {
    formatNumber
}