import cv2
import numpy as np
import pytest
import toml

cameras = devices_dict = toml.load("resources/config.toml")['Cameras']


@pytest.mark.parametrize("cameras", cameras.items())
class TestCameras:

    @pytest.fixture(scope='function', autouse=True)
    def setup_method(self, cameras):
        self.name = cameras[0]
        parameters = cameras[1]
        self.main_stream = parameters['main_stream']
        self.backup_stream = parameters['backup_stream']

    def test_privacy_mode(self):
        capture = cv2.VideoCapture(self.main_stream)

        ret, frame = capture.read()

        capture.release()

        if not ret:
            capture = cv2.VideoCapture(self.backup_stream)

            ret, frame = capture.read()

            capture.release()

        assert ret

        frame = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

        black_color = np.array([0, 0, 0])

        color_range = cv2.inRange(frame, black_color, black_color)

        percentage_color = (np.count_nonzero(color_range) / (frame.shape[0] * frame.shape[1])) * 100

        assert percentage_color <= 75

