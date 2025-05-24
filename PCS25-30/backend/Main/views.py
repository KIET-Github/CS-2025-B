from rest_framework import status, generics
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, FormParser
from PIL import Image
import numpy as np
import tensorflow as tf
from django.conf import settings
from .models import Scheme
from .serializers import SchemeSerializer
from .constants import DISEASE_DESCRIPTION, CURE_DESCRIPTION 

# Load the model
model_path = settings.MODEL_PATH
model = tf.keras.models.load_model(model_path)

def predict_class(image):
    original_image = Image.open(image)
    preprocessed_image = original_image.resize((256, 256))
    preprocessed_image = np.array(preprocessed_image) / 255.0

    preds = model.predict(np.expand_dims(preprocessed_image, axis=0))
    labels = ['Healthy', 'Powdery', 'Rust']

    preds_class = np.argmax(preds)
    preds_label = labels[preds_class]

    return preds_label, round(preds[0][preds_class], 2)

@api_view(['POST'])
def diagnose(request):
    parser_classes = [MultiPartParser, FormParser]

    if 'image' not in request.FILES:
        return Response({'error': 'No image provided'}, status=status.HTTP_400_BAD_REQUEST)

    image = request.FILES['image']
    label, confidence = predict_class(image)
    description = DISEASE_DESCRIPTION.get(label, "No description available.")
    cure = CURE_DESCRIPTION.get(label, "No cure information available.")

    result = {
        'prediction_disease': label,
        'prediction_confidence': confidence,
        'description': description,
        'cure': cure
    }

    return Response(result, status=status.HTTP_200_OK)


class SchemeListView(generics.ListCreateAPIView):
    queryset = Scheme.objects.all()
    serializer_class = SchemeSerializer
