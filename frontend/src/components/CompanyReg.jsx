import React from 'react'

const CompanyReg = () => {
    return (
        <div className='text-white container'>
            <form action="/api/form" method='post'>
                <h2 className='text-3xl text-semibold text-white font-mont text-center mb-5\'>Company Registration</h2>
                <label for="name">Company Name: </label>
                <input type="text" id="name" name="name" /><br />
                <label for="CO2">CO2 equivalent emissions in metric tons:   </label>
                <input type="text" id="CO2" name="CO2" /><br />
                <label for="SO2">SO2 equivalent emissions in metric tons:   </label>
                <input type="text" id="SO2" name="SO2" /><br />
                <label for="CFC">CFC equivalent emissions in metric tons:   </label>
                <input type="text" id="CFC" name="CFC" /><br />
                <label for="type">Choose type of Industry:  </label>
                <select id="type" name="type">
                    <option value="Food">Food</option>
                    <option value="Manufacturing">Manufacturing</option>
                    <option value="Technology">Technology</option>
                    <option value="Agriculture">Agriculture</option>
                </select><br />

                <input type="submit" />
            </form>
        </div>
    )
}

export default CompanyReg