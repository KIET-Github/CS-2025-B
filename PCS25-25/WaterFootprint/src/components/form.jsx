import React, { Component } from 'react';

class InputForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      country: '',
      gender: '',
      income: '',
    };
  }

  handleChange = (e) => {
    const { name, value } = e.target;
    this.setState({ [name]: value });
  }

  handleSubmit = (e) => {
    e.preventDefault();
    // You can handle form submission here, e.g., send data to a server or perform some action.
    // For now, we'll just log the input values to the console.
    console.log('Form submitted with values:', this.state);
  }

  render() {
    return (
      <div>
        <h1>Input Form</h1>
        {/* <form onSubmit={this.handleSubmit}>
          <div>
            <label htmlFor="country">Country:</label>
            <input
              type="text"
              id="country"
              name="country"
              value={this.state.country}
              onChange={this.handleChange}
              required
            />
          </div>
          <div>
            <label htmlFor="gender">Gender:</label>
            <select
              id="gender"
              name="gender"
              value={this.state.gender}
              onChange={this.handleChange}
              required
            >
              <option value="">Select Gender</option>
              <option value="male">Male</option>
              <option value="female">Female</option>
              <option value="other">Other</option>
            </select>
          </div>
          <div>
            <label htmlFor="income">Income:</label>
            <input
              type="number"
              id="income"
              name="income"
              value={this.state.income}
              onChange={this.handleChange}
              required
            />
          </div>
          <button type="submit">Submit</button>
        </form> */}
      </div>
    );
  }
}

export default InputForm;
