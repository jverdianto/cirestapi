<?php

use Restserver\Libraries\REST_Controller;

defined('BASEPATH') or exit('No direct script access allowed');

require APPPATH . 'libraries/REST_Controller.php';
require APPPATH . 'libraries/Format.php';

class Mahasiswa extends REST_Controller
{

    function __construct($config = 'rest')
    {
        parent::__construct($config);
        $this->load->model('Mahasiswamodel', 'model');
    }

    public function index_get()
    {
        $data = $this->model->getMahasiswa();
        $this->set_response([
          'status' => TRUE,
          'code' => 200,
          'message' => 'Success',
          'data' => $data,  
        ], REST_Controller::HTTP_OK);
    }

    public function sendmail_post(){
        $to_email = $this->post('email');
        $this->load->library('email');
        $this->email->from('info@jeffrey.ngantokimt.com', 'Raja Ongkir');
        $this->email->to($to_email);
        $this->email->subject('Verfikasi Akun Raja Ongkir');
        $this->email->message("
            <center>
                <div style='border: 5px solid #b100cd; border-radius: 20px'>
                <h1 style='font-weight: bold;'>WELCOME TO RAJA ONGKIR</h1>
                <img style='width=100px; height=100px' src='https://play-lh.googleusercontent.com/YvkbAQsX24-KZKVmHTV_XIbJmttPLmQ5VRgPVqvGFMlF86m3Q52AJd3zb5hYCTcBfjM'>
                <p>Terima kasih telah bergabung dengan RajaOngkir. Sebelum menggunakan akun Anda, harap lakukan aktivasi dengan mengklik tombol di bawah ini:</p>
                <button style='
                    background-color: #b100cd;
                    border-color: none;
                    color: white;
                    padding: 15px 32px;
                    text-align: center;
                    display: inline-block;
                    font-size: 16px;
                    margin: 4px 2px;
                    cursor: pointer;
                '> Verifikasi Akun </button>
            </center>
        ");

        if($this->email->send()){
            $this->set_response([
                'status' => TRUE,
                'code' => 200,
                'message' => 'Email informasi penting berhasil dikirim'
                ], REST_Controller::HTTP_OK);
        }else{
            $this->set_response([
                'status' => FALSE,
                // 'code' => 404,
                'message' => 'Gagal mengirim email'
                ], REST_Controller::HTTP_NOT_FOUND);
        }

    }

}