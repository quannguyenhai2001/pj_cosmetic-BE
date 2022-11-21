const billInfo = document.querySelector('.content-table');
const main = async () => {

    // try {
    let a = await axios({
        url: 'http://localhost/api/bills/get-all-bills.php',
        method: 'get',
        data: null,
    })
    let result = a.data.data.map(item => {
        if (item.status === 'Success') {
            return `
            <td>${item.id}</td>
            <td>${item.receiverName}</td>
            <td>${item.phone}</td>
            <td>${item.deliveryDate}</td>
            <td>${item.total}</td>
            <td>${item.deliveryAddress}</td>
            <td>${item.paymentMethod}</td>
            <td>${item.notes}</td>
            <td>Success</td>
             ` }
        else {
            return `
                 <td>${item.id}</td>
            <td>${item.receiverName}</td>
            <td>${item.phone}</td>
            <td>${item.deliveryDate}</td>
            <td>${item.total}</td>
            <td>${item.deliveryAddress}</td>
            <td>${item.paymentMethod}</td>
            <td>${item.notes}</td>
            <td>
                <input type="checkbox" onclick = "updateStatus(${item.id})">
            </td>
                 `
        }
    });
    result.forEach(element => {
        let para = document.createElement("tr")
        para.innerHTML = element
        billInfo.appendChild(para)

    });
}

main();

async function updateStatus(id) {
    try {
        let isCheckupdate = window.confirm("Hello, do you want to update status?");
        if (isCheckupdate) {
            let a = await axios({
                url: 'http://localhost/api/bills/update-bill.php',
                method: 'put',
                data: {
                    bill_Id: id,
                },
                headers: {

                    'Authorization': `Bearer ${localStorage.getItem('token')}`
                }
            })
            location.reload();

        }
    }
    catch (error) {
        console.error(error.response)
    }
}