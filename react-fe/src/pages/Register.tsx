import { RegisterFormModel } from '../../models/RegisterFormModel';
import { useState } from 'react';
import { registerUser } from '../services/endpointFetching';

// Material UI Imports
import { Button, TextField, FormControl, FormLabel, RadioGroup, FormControlLabel, Radio } from '@mui/material';

import '../styles/register.css';

export const Register = () => {
  const [registerForm, setRegisterForm] = useState<RegisterFormModel>({
    userName: '',
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    profilePictureUrl: '',
    birthDate: '',
    gender: true,
    married: false,
    bios: '',
    religion: '',
  });

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    registerUser(registerForm);
  };

  return (
    <div className="Register">
      <form onSubmit={handleSubmit}>
        <TextField
          id="outlined-basic"
          label="Username"
          variant="outlined"
          onChange={(e) => setRegisterForm({ ...registerForm, userName: e.target.value })}
        />
        <TextField
          id="outlined-basic"
          label="First Name"
          variant="outlined"
          onChange={(e) => setRegisterForm({ ...registerForm, firstName: e.target.value })}
        />
        <TextField
          id="outlined-basic"
          label="Last Name"
          variant="outlined"
          onChange={(e) => setRegisterForm({ ...registerForm, lastName: e.target.value })}
        />
        <TextField
          id="outlined-basic"
          label="Email"
          variant="outlined"
          onChange={(e) => setRegisterForm({ ...registerForm, email: e.target.value })}
        />
        <TextField
          id="outlined-basic"
          label="Password"
          variant="outlined"
          type="password"
          onChange={(e) => setRegisterForm({ ...registerForm, password: e.target.value })}
        />

        {/* Additional Fields */}
        <TextField
          id="outlined-basic"
          label="Profile Picture URL"
          variant="outlined"
          onChange={(e) => setRegisterForm({ ...registerForm, profilePictureUrl: e.target.value })}
        />
        <TextField
          id="outlined-basic"
          variant="outlined"
          type="date"
          onChange={(e) => setRegisterForm({ ...registerForm, birthDate: e.target.value })}
        />

        <FormControl component="fieldset">
          <FormLabel component="legend">Gender</FormLabel>
          <RadioGroup
            row
            aria-label="gender"
            name="gender"
            value={registerForm.gender.toString()}
            onChange={(e) => setRegisterForm({ ...registerForm, gender: e.target.value === 'true' })}
          >
            <FormControlLabel value="true" control={<Radio />} label="Male" />
            <FormControlLabel value="false" control={<Radio />} label="Female" />
          </RadioGroup>
        </FormControl>

        <FormControl component="fieldset">
          <FormLabel component="legend">Marital Status</FormLabel>
          <RadioGroup
            row
            aria-label="marital-status"
            name="maritalStatus"
            value={registerForm.married.toString()}
            onChange={(e) => setRegisterForm({ ...registerForm, married: e.target.value === 'true' })}
          >
            <FormControlLabel value="true" control={<Radio />} label="Married" />
            <FormControlLabel value="false" control={<Radio />} label="Single" />
          </RadioGroup>
        </FormControl>

        <TextField
          id="outlined-basic"
          label="Bios"
          variant="outlined"
          multiline
          rows={4}
          onChange={(e) => setRegisterForm({ ...registerForm, bios: e.target.value })}
        />

        <TextField
          id="outlined-basic"
          label="Religion"
          variant="outlined"
          onChange={(e) => setRegisterForm({ ...registerForm, religion: e.target.value })}
        />

        <Button variant="contained" type="submit">
          Register
        </Button>
      </form>
    </div>
  );
};
