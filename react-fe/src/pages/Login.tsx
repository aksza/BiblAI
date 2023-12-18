import { useState } from 'react';
import { loginUser } from '../services/endpointFetching';
import { Button, Link, TextField } from '@mui/material';

interface LoginFormModel {
  userName: string;
  password: string;
}

export const Login = () => {
  const [loginForm, setLoginForm] = useState<LoginFormModel>({
    userName: '',
    password: '',
  });

  const [token, setToken] = useState<string | null>(null);
  const [errorMessage, setErrorMessage] = useState<string>('');

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const token = await loginUser(loginForm.userName, loginForm.password);
    if (token) {
      setToken(token as string);
      localStorage.setItem('token', token as string);
      window.location.href = '/home';
    } else {
      setErrorMessage('Incorrect username or password');
    }
  }

  return (
    <div className="Login">
      <form onSubmit={handleSubmit}>
        <TextField
          id="outlined-basic"
          label="Username"
          variant="outlined"
          onChange={(e) => setLoginForm({ ...loginForm, userName: e.target.value })}
        />
        <TextField
          id="outlined-basic"
          label="Password"
          variant="outlined"
          type="password"
          onChange={(e) => setLoginForm({ ...loginForm, password: e.target.value })}
        />
        <Button variant="contained" type="submit">
          Login
        </Button>
      </form>
      {errorMessage && <p>{errorMessage}</p>}
      <Link href="/register">Register</Link>
    </div>
  );
};